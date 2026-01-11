use anyhow::Result;
use chrono::NaiveDateTime;
use serialport::SerialPort;
use std::io::{Read, Write};
use thiserror::Error;

#[derive(Debug, PartialEq, Clone, Copy)]
pub enum TimeWeighting {
    Fast,
    Slow,
}

impl TimeWeighting {
    pub fn as_str(&self) -> &'static str {
        match self {
            TimeWeighting::Fast => "Fast",
            TimeWeighting::Slow => "Slow",
        }
    }
}

#[derive(Debug, PartialEq, Clone, Copy)]
pub enum FrequencyWeighting {
    DBA,
    DBC,
}

impl FrequencyWeighting {
    pub fn as_str(&self) -> &'static str {
        match self {
            FrequencyWeighting::DBA => "dB(A)",
            FrequencyWeighting::DBC => "dB(C)",
        }
    }
}

#[derive(Debug, PartialEq, Clone, Copy)]
pub enum RangeThreshold {
    Under,
    Ok,
    Over,
}

impl RangeThreshold {
    pub fn as_str(&self) -> &'static str {
        match self {
            RangeThreshold::Under => "Under range",
            RangeThreshold::Ok => "Within range",
            RangeThreshold::Over => "Over range",
        }
    }
}

#[derive(Debug, PartialEq, Clone, Copy)]
pub enum HoldMode {
    Live,
    Min,
    Max,
}

impl HoldMode {
    pub fn as_str(&self) -> &'static str {
        match self {
            HoldMode::Live => "Live",
            HoldMode::Min => "Minimum hold",
            HoldMode::Max => "Maximum hold",
        }
    }
}

#[derive(Debug, PartialEq, Clone, Copy)]
pub enum RangeMode {
    R30_80,
    R50_100,
    R80_130,
    R30_130Auto,
}

impl RangeMode {
    pub fn as_str(&self) -> &'static str {
        match self {
            RangeMode::R30_80 => "30dB - 80dB",
            RangeMode::R50_100 => "50dB - 100dB",
            RangeMode::R80_130 => "80dB - 130dB",
            RangeMode::R30_130Auto => "30dB - 130dB auto range",
        }
    }
}

#[derive(Debug, PartialEq, Clone, Copy)]
pub enum RecordingMode {
    NotRecording,
    Recording,
}

impl RecordingMode {
    pub fn as_str(&self) -> &'static str {
        match self {
            RecordingMode::NotRecording => "Not recording",
            RecordingMode::Recording => "Recording",
        }
    }
}

#[derive(Debug, PartialEq, Clone, Copy)]
pub enum MemoryStore {
    Available,
    Full,
}

impl MemoryStore {
    pub fn as_str(&self) -> &'static str {
        match self {
            MemoryStore::Available => "Storage available",
            MemoryStore::Full => "Storage full",
        }
    }
}

#[derive(Debug, PartialEq, Clone, Copy)]
pub enum BatteryState {
    Ok,
    Low,
}

impl BatteryState {
    pub fn as_str(&self) -> &'static str {
        match self {
            BatteryState::Ok => "Battery OK",
            BatteryState::Low => "Battery low",
        }
    }
}

#[derive(Debug, PartialEq, Clone, Copy)]
pub enum OutputTo {
    Display,
    BarGraph,
}

impl OutputTo {
    pub fn as_str(&self) -> &'static str {
        match self {
            OutputTo::Display => "Digits",
            OutputTo::BarGraph => "Bar graph",
        }
    }
}

#[derive(Debug, Clone, Copy)]
#[repr(u8)]
pub enum CommandToken {
    PowerDown = 0x33,
    ToggleRecordingMode = 0x55,
    ToggleHoldMode = 0x11,
    ToggleTimeWeighting = 0x77,
    ToggleRangeMode = 0x88,
    ToggleFrequencyWeighting = 0x99,
    GetRecording = 0xac,
}

#[derive(Debug, Clone)]
pub struct Dt8852State {
    pub current_spl: Option<f64>,
    pub current_time: Option<NaiveDateTime>, // Using NaiveDateTime arbitrarily, might need adjustment
    pub time_weighting: Option<TimeWeighting>,
    pub frequency_weighting: Option<FrequencyWeighting>,
    pub range_threshold: Option<RangeThreshold>,
    pub hold_mode: Option<HoldMode>,
    pub range_mode: Option<RangeMode>,
    pub recording_mode: Option<RecordingMode>,
    pub memory_store: Option<MemoryStore>,
    pub battery_state: Option<BatteryState>,
    pub output_to: Option<OutputTo>,
}

impl Default for Dt8852State {
    fn default() -> Self {
        Self {
            current_spl: None,
            current_time: None,
            time_weighting: None,
            frequency_weighting: None,
            range_threshold: None,
            hold_mode: None,
            range_mode: None,
            recording_mode: None,
            memory_store: None,
            battery_state: None,
            output_to: None,
        }
    }
}

#[derive(Error, Debug)]
pub enum Dt8852Error {
    #[error("Serial port error")]
    Serial(#[from] serialport::Error),
    #[error("IO error")]
    Io(#[from] std::io::Error),
    #[error("Unknown token: {0}")]
    UnknownToken(String),
}

pub struct Dt8852 {
    port: Box<dyn SerialPort>,
    pub state: Dt8852State,
    set_modes: Vec<ConfigMode>,
    set_mode_command: Option<CommandToken>,
    wait_for_value: Option<ConfigMode>,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum ConfigMode {
    Time(TimeWeighting),
    Frequency(FrequencyWeighting),
    Range(RangeMode),
    Hold(HoldMode),
    Recording(RecordingMode),
}

#[derive(Debug)]
pub enum Token {
    TimeWeighting(TimeWeighting),
    HoldMode(HoldMode),
    CurrentTime(NaiveDateTime),
    RangeThreshold(RangeThreshold),
    MemoryStore(MemoryStore),
    RecordingMode(RecordingMode),
    OutputTo(OutputTo),
    CurrentSpl(f64),
    BatteryState(BatteryState),
    FrequencyWeighting(FrequencyWeighting),
    RangeMode(RangeMode),
}

impl Dt8852 {
    pub fn new(port: Box<dyn SerialPort>) -> Result<Self> {
        port.clear(serialport::ClearBuffer::Input)?;
        port.clear(serialport::ClearBuffer::Output)?;
        Ok(Self {
            port,
            state: Dt8852State::default(),
            set_modes: Vec::new(),
            set_mode_command: None,
            wait_for_value: None,
        })
    }

    pub fn set_mode(&mut self, modes: Vec<ConfigMode>) {
        self.set_modes = modes;
        self.set_next_mode(true);
    }

    fn set_next_mode(&mut self, first: bool) {
        if !first && !self.set_modes.is_empty() {
            self.set_modes.remove(0);
        }

        if self.set_modes.is_empty() {
            self.set_mode_command = None;
            return;
        }

        let mode = self.set_modes[0];
        self.wait_for_value = Some(mode);

        self.set_mode_command = Some(match mode {
            ConfigMode::Time(_) => CommandToken::ToggleTimeWeighting,
            ConfigMode::Frequency(_) => CommandToken::ToggleFrequencyWeighting,
            ConfigMode::Range(_) => CommandToken::ToggleRangeMode,
            ConfigMode::Hold(_) => CommandToken::ToggleHoldMode,
            ConfigMode::Recording(_) => CommandToken::ToggleRecordingMode,
        });
    }

    pub fn is_configuring(&self) -> bool {
        !self.set_modes.is_empty() || self.set_mode_command.is_some()
    }

    pub fn decode_next_token(&mut self, changes_only: bool) -> Result<Option<(String, Token, bool)>> {
        let supported_tokens = [
            0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
            0x11, 0x19, 0x1a, 0x1b, 0x1c, 0x1f, 0x30, 0x40, 0x4b, 0x4c,
        ];

        let mut set_mode_throttle_counter = 0;
        let mut buf = [0u8; 1];

        loop {
            // Wait for token start byte
            loop {
                self.port.read_exact(&mut buf)?;
                if buf[0] == 0xa5 {
                    break;
                }
            }

            self.port.read_exact(&mut buf)?;
            let token_byte = buf[0];
            
            if !supported_tokens.contains(&token_byte) {
                continue;
            }

            let (name, decoded_token, value_changed) = self.decode_token(token_byte)?;

            // Handle device configuration
            if let Some(cmd) = self.set_mode_command {
                set_mode_throttle_counter += 1;

                let mode_matched = match (self.wait_for_value, &decoded_token) {
                    (Some(ConfigMode::Time(target)), Token::TimeWeighting(val)) => target == *val,
                    (Some(ConfigMode::Frequency(target)), Token::FrequencyWeighting(val)) => target == *val,
                    (Some(ConfigMode::Range(target)), Token::RangeMode(val)) => target == *val,
                    (Some(ConfigMode::Hold(target)), Token::HoldMode(val)) => target == *val,
                    (Some(ConfigMode::Recording(target)), Token::RecordingMode(val)) => target == *val,
                    _ => false,
                };

                if mode_matched {
                     self.set_next_mode(false);
                } else if set_mode_throttle_counter % 9 == 0 {
                    self.port.write_all(&[cmd as u8])?;
                    self.port.flush()?;
                }
            }

            if value_changed || !changes_only {
                return Ok(Some((name, decoded_token, value_changed)));
            }
        }
    }

    fn decode_token(&mut self, token: u8) -> Result<(String, Token, bool)> {
        match token {
            0x02 => {
                 let changed = self.state.time_weighting != Some(TimeWeighting::Fast);
                 self.state.time_weighting = Some(TimeWeighting::Fast);
                 Ok(("time_weighting".to_string(), Token::TimeWeighting(TimeWeighting::Fast), changed))
            },
            0x03 => {
                 let changed = self.state.time_weighting != Some(TimeWeighting::Slow);
                 self.state.time_weighting = Some(TimeWeighting::Slow);
                 Ok(("time_weighting".to_string(), Token::TimeWeighting(TimeWeighting::Slow), changed))
            },
            0x04 => {
                 let changed = self.state.hold_mode != Some(HoldMode::Max);
                 self.state.hold_mode = Some(HoldMode::Max);
                 Ok(("hold_mode".to_string(), Token::HoldMode(HoldMode::Max), changed))
            },
            0x05 => {
                 let changed = self.state.hold_mode != Some(HoldMode::Min);
                 self.state.hold_mode = Some(HoldMode::Min);
                 Ok(("hold_mode".to_string(), Token::HoldMode(HoldMode::Min), changed))
            },
            0x06 => {
                let mut data = [0u8; 3];
                self.port.read_exact(&mut data)?;
                // Time parsing logic needed here. Python logic:
                // hours = data[0] & 0x1F, minutes=data[1], seconds=data[2]
                // ampm = data[0] >> 5 (0=am, 1=pm)
                let hours_raw = data[0] & 0x1F;
                let minutes_raw = data[1];
                let seconds_raw = data[2];
                let is_pm = (data[0] >> 5) > 0;
                
                let mut hours = u8::from_str_radix(&format!("{:02x}", hours_raw), 10).unwrap_or(0);
                let minutes = u8::from_str_radix(&format!("{:02x}", minutes_raw), 10).unwrap_or(0);
                let seconds = u8::from_str_radix(&format!("{:02x}", seconds_raw), 10).unwrap_or(0);

                if hours == 0 && !is_pm { // Python code says 00 AM -> 12 AM
                   hours = 12;
                }
                
                // Convert to 24-hour if PM
                if is_pm && hours < 12 {
                    hours += 12;
                } else if !is_pm && hours == 12 {
                    hours = 0;
                }

                // Construct NaiveTime then NaiveDateTime (using dummy date)
                 let time = chrono::NaiveTime::from_hms_opt(hours as u32, minutes as u32, seconds as u32)
                     .unwrap_or_default();
                 // We don't really have the date... let's just use "today" or a fixed date since we only care about time mostly? 
                 // The python code returns a time struct.
                 // Ideally we just return NaiveTime but my struct has NaiveDateTime.
                 // Let's assume today for now for simpler implementation.
                 let now = chrono::Local::now().naive_local();
                 let dt = chrono::NaiveDateTime::new(now.date(), time);

                 let changed = self.state.current_time != Some(dt);
                 self.state.current_time = Some(dt);
                 Ok(("current_time".to_string(), Token::CurrentTime(dt), changed))
            },
            0x07 => {
                 let changed = self.state.range_threshold != Some(RangeThreshold::Over);
                 self.state.range_threshold = Some(RangeThreshold::Over);
                 Ok(("range_threshold".to_string(), Token::RangeThreshold(RangeThreshold::Over), changed))
            },
            0x08 => {
                 let changed = self.state.range_threshold != Some(RangeThreshold::Under);
                 self.state.range_threshold = Some(RangeThreshold::Under);
                 Ok(("range_threshold".to_string(), Token::RangeThreshold(RangeThreshold::Under), changed))
            },
            0x09 => {
                 let changed = self.state.memory_store != Some(MemoryStore::Full);
                 self.state.memory_store = Some(MemoryStore::Full);
                 Ok(("memory_store".to_string(), Token::MemoryStore(MemoryStore::Full), changed))
            },
            0x0a => {
                 let changed = self.state.recording_mode != Some(RecordingMode::Recording);
                 self.state.recording_mode = Some(RecordingMode::Recording);
                 Ok(("recording_mode".to_string(), Token::RecordingMode(RecordingMode::Recording), changed))
            },
            0x0b => {
                 let changed = self.state.output_to != Some(OutputTo::Display);
                 self.state.output_to = Some(OutputTo::Display);
                 Ok(("output_to".to_string(), Token::OutputTo(OutputTo::Display), changed))
            },
            0x0c => {
                 let changed = self.state.output_to != Some(OutputTo::BarGraph);
                 self.state.output_to = Some(OutputTo::BarGraph);
                 Ok(("output_to".to_string(), Token::OutputTo(OutputTo::BarGraph), changed))
            },
            0x0d => {
                let mut data = [0u8; 2];
                self.port.read_exact(&mut data)?;
                let spl_bcd = format!("{:x}{:02x}", data[0], data[1]);
                let current_spl = spl_bcd.parse::<f64>().unwrap_or(0.0) / 10.0;
                let changed = self.state.current_spl != Some(current_spl);
                self.state.current_spl = Some(current_spl);
                Ok(("current_spl".to_string(), Token::CurrentSpl(current_spl), changed))
            },
            0x0e => {
                 let changed = self.state.hold_mode != Some(HoldMode::Live);
                 self.state.hold_mode = Some(HoldMode::Live);
                 Ok(("hold_mode".to_string(), Token::HoldMode(HoldMode::Live), changed))
            },
            0x0f => {
                 let changed = self.state.battery_state != Some(BatteryState::Low);
                 self.state.battery_state = Some(BatteryState::Low);
                 Ok(("battery_state".to_string(), Token::BatteryState(BatteryState::Low), changed))
            },
            0x11 => {
                 let changed = self.state.range_threshold != Some(RangeThreshold::Ok);
                 self.state.range_threshold = Some(RangeThreshold::Ok);
                 Ok(("range_threshold".to_string(), Token::RangeThreshold(RangeThreshold::Ok), changed))
            },
            0x19 => {
                 let changed = self.state.memory_store != Some(MemoryStore::Available);
                 self.state.memory_store = Some(MemoryStore::Available);
                 Ok(("memory_store".to_string(), Token::MemoryStore(MemoryStore::Available), changed))
            },
            0x1a => {
                 let changed = self.state.recording_mode != Some(RecordingMode::NotRecording);
                 self.state.recording_mode = Some(RecordingMode::NotRecording);
                 Ok(("recording_mode".to_string(), Token::RecordingMode(RecordingMode::NotRecording), changed))
            },
            0x1b => {
                 let changed = self.state.frequency_weighting != Some(FrequencyWeighting::DBA);
                 self.state.frequency_weighting = Some(FrequencyWeighting::DBA);
                 Ok(("frequency_weighting".to_string(), Token::FrequencyWeighting(FrequencyWeighting::DBA), changed))
            },
            0x1c => {
                 let changed = self.state.frequency_weighting != Some(FrequencyWeighting::DBC);
                 self.state.frequency_weighting = Some(FrequencyWeighting::DBC);
                 Ok(("frequency_weighting".to_string(), Token::FrequencyWeighting(FrequencyWeighting::DBC), changed))
            },
            0x1f => {
                 let changed = self.state.battery_state != Some(BatteryState::Ok);
                 self.state.battery_state = Some(BatteryState::Ok);
                 Ok(("battery_state".to_string(), Token::BatteryState(BatteryState::Ok), changed))
            },
            0x30 => {
                 let changed = self.state.range_mode != Some(RangeMode::R30_80);
                 self.state.range_mode = Some(RangeMode::R30_80);
                 Ok(("range_mode".to_string(), Token::RangeMode(RangeMode::R30_80), changed))
            },
            0x40 => {
                 let changed = self.state.range_mode != Some(RangeMode::R30_130Auto);
                 self.state.range_mode = Some(RangeMode::R30_130Auto);
                 Ok(("range_mode".to_string(), Token::RangeMode(RangeMode::R30_130Auto), changed))
            },
            0x4b => {
                 let changed = self.state.range_mode != Some(RangeMode::R50_100);
                 self.state.range_mode = Some(RangeMode::R50_100);
                 Ok(("range_mode".to_string(), Token::RangeMode(RangeMode::R50_100), changed))
            },
            0x4c => {
                 let changed = self.state.range_mode != Some(RangeMode::R80_130);
                 self.state.range_mode = Some(RangeMode::R80_130);
                 Ok(("range_mode".to_string(), Token::RangeMode(RangeMode::R80_130), changed))
            },  
            _ => Err(Dt8852Error::UnknownToken(format!("{:02x}", token)).into())
        }
    }
}
