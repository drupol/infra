use clap::{Parser, Subcommand, ValueEnum};
use std::time::Duration;
use dt8852::{Dt8852, ConfigMode, TimeWeighting, FrequencyWeighting, RangeMode, HoldMode, RecordingMode, OutputTo};

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Cli {
    #[arg(long, default_value = "/dev/ttyUSB0")]
    serial_port: String,

    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand, Debug)]
enum Commands {
    Live {
        #[arg(short, long, action = clap::ArgAction::Count)]
        verbosity: u8,

        #[clap(flatten)]
        mode_args: ModeArgs,

        #[arg(long, value_enum, default_value_t = OutputFormat::Text)]
        format: OutputFormat,
    },
    SetMode {
        #[clap(flatten)]
        mode_args: ModeArgs,
    },
    GetMode,
    Download,
}

#[derive(Parser, Debug)]
struct ModeArgs {
    #[arg(long, value_enum)]
    range: Option<RangeModeEnum>,

    #[arg(long, value_enum)]
    freqweighting: Option<FrequencyWeightingEnum>,

    #[arg(long, value_enum)]
    timeweighting: Option<TimeWeightingEnum>,

    #[arg(long, value_enum)]
    hold: Option<HoldModeEnum>,

    #[arg(long, value_enum)]
    record: Option<RecordingModeEnum>,
}

#[derive(ValueEnum, Copy, Clone, Debug, PartialEq)]
enum RangeModeEnum {
    #[value(name = "R_30_80")]
    R30_80,
    #[value(name = "R_50_100")]
    R50_100,
    #[value(name = "R_80_130")]
    R80_130,
    #[value(name = "R_30_130_AUTO")]
    R30_130Auto,
}

impl From<RangeModeEnum> for RangeMode {
    fn from(val: RangeModeEnum) -> Self {
        match val {
            RangeModeEnum::R30_80 => RangeMode::R30_80,
            RangeModeEnum::R50_100 => RangeMode::R50_100,
            RangeModeEnum::R80_130 => RangeMode::R80_130,
            RangeModeEnum::R30_130Auto => RangeMode::R30_130Auto,
        }
    }
}

#[derive(ValueEnum, Copy, Clone, Debug, PartialEq)]
enum FrequencyWeightingEnum {
    DBA,
    DBC,
}

impl From<FrequencyWeightingEnum> for FrequencyWeighting {
    fn from(val: FrequencyWeightingEnum) -> Self {
        match val {
            FrequencyWeightingEnum::DBA => FrequencyWeighting::DBA,
            FrequencyWeightingEnum::DBC => FrequencyWeighting::DBC,
        }
    }
}

#[derive(ValueEnum, Copy, Clone, Debug, PartialEq)]
enum TimeWeightingEnum {
    Fast,
    Slow,
}

impl From<TimeWeightingEnum> for TimeWeighting {
    fn from(val: TimeWeightingEnum) -> Self {
        match val {
            TimeWeightingEnum::Fast => TimeWeighting::Fast,
            TimeWeightingEnum::Slow => TimeWeighting::Slow,
        }
    }
}

#[derive(ValueEnum, Copy, Clone, Debug, PartialEq)]
enum HoldModeEnum {
    Live,
    Min,
    Max,
}

impl From<HoldModeEnum> for HoldMode {
    fn from(val: HoldModeEnum) -> Self {
        match val {
            HoldModeEnum::Live => HoldMode::Live,
            HoldModeEnum::Min => HoldMode::Min,
            HoldModeEnum::Max => HoldMode::Max,
        }
    }
}

#[derive(ValueEnum, Copy, Clone, Debug, PartialEq)]
enum RecordingModeEnum {
    NotRecording,
    Recording,
}

impl From<RecordingModeEnum> for RecordingMode {
    fn from(val: RecordingModeEnum) -> Self {
        match val {
            RecordingModeEnum::NotRecording => RecordingMode::NotRecording,
            RecordingModeEnum::Recording => RecordingMode::Recording,
        }
    }
}

fn get_modes_from_args(args: &ModeArgs) -> Vec<ConfigMode> {
    let mut modes = Vec::new();
    if let Some(range) = args.range {
        modes.push(ConfigMode::Range(range.into()));
    }
    if let Some(freq) = args.freqweighting {
        modes.push(ConfigMode::Frequency(freq.into()));
    }
    if let Some(time) = args.timeweighting {
        modes.push(ConfigMode::Time(time.into()));
    }
    if let Some(hold) = args.hold {
        modes.push(ConfigMode::Hold(hold.into()));
    }
    if let Some(rec) = args.record {
        modes.push(ConfigMode::Recording(rec.into()));
    }
    modes
}

#[derive(ValueEnum, Copy, Clone, Debug, PartialEq)]
enum OutputFormat {
    Text,
    Telegraf,
}


fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();

    let port = serialport::new(&cli.serial_port, 9600)
        .timeout(Duration::from_millis(10000)) // Generous timeout
        .open()?;

    let mut dt8852 = Dt8852::new(port)?;

    match &cli.command {
        Commands::Live { verbosity, mode_args, format } => {
            dt8852.set_mode(get_modes_from_args(mode_args));

            loop {
                 let result = dt8852.decode_next_token(*verbosity == 4)?;
                 if let Some((name, token, _value_changed)) = result {
                     if let OutputFormat::Telegraf = format {
                         if name == "output_to" {
                             if let dt8852::Token::OutputTo(OutputTo::Display) = token {
                                 if let Some(spl) = dt8852.state.current_spl {
                                    let escape = |s: &str| s.replace(' ', "\\ ").replace(',', "\\,").replace('=', "\\=");
                                    let mut tags = Vec::new();
                                    if let Some(fw) = dt8852.state.frequency_weighting { tags.push(format!("frequency_weighting={}", escape(fw.as_str()))); }
                                    if let Some(tw) = dt8852.state.time_weighting { tags.push(format!("time_weighting={}", escape(tw.as_str()))); }
                                    if let Some(rm) = dt8852.state.range_mode { tags.push(format!("range_mode={}", escape(rm.as_str()))); }
                                    if let Some(hm) = dt8852.state.hold_mode { tags.push(format!("hold_mode={}", escape(hm.as_str()))); }

                                    let tag_str = if tags.is_empty() { String::new() } else { format!(",{}", tags.join(",")) };
                                    println!("dt8852{} spl={}", tag_str, spl);
                                 }
                             }
                         }
                         continue;
                     }

                     if *verbosity <= 1 {
                         if name == "output_to" {
                             if let dt8852::Token::OutputTo(OutputTo::Display) = token {
                                 if let Some(spl) = dt8852.state.current_spl {
                                      if *verbosity == 0 {
                                          println!("{}", spl);
                                      } else {
                                           let time_str = dt8852.state.current_time.map(|t| t.to_string()).unwrap_or("Unknown".to_string());
                                           println!("{},{}", time_str, spl);
                                      }
                                 }
                             }
                         }

                     } else if *verbosity <= 3 {
                        if name == "current_spl" {
                             if let dt8852::Token::CurrentSpl(spl) = token {
                                  if *verbosity == 2 {
                                      println!("{}", spl);
                                  } else {
                                       let time_str = dt8852.state.current_time.map(|t| t.to_string()).unwrap_or("Unknown".to_string());
                                       println!("{},{}", time_str, spl);
                                  }
                             }
                        }
                     } else {
                         // Verbosity 4 or 5
                         println!("{:?}", token);
                     }
                 }
            }
        },
        Commands::SetMode { mode_args } => {
            let modes = get_modes_from_args(mode_args);
            dt8852.set_mode(modes);

            loop {
                dt8852.decode_next_token(true)?;
                if !dt8852.is_configuring() {
                    break;
                }
            }
            println!("{:?}", dt8852.state);
        },
        Commands::GetMode => {
            // Loop until we have all values?
            loop {
                 dt8852.decode_next_token(true)?;
                 let s = &dt8852.state;
                 if s.current_spl.is_some() && s.current_time.is_some() &&
                    s.time_weighting.is_some() && s.frequency_weighting.is_some() &&
                    s.range_threshold.is_some() && s.hold_mode.is_some() &&
                    s.range_mode.is_some() && s.recording_mode.is_some() &&
                    s.memory_store.is_some() && s.battery_state.is_some() &&
                    s.output_to.is_some() {
                        break;
                    }
            }
            println!("{:?}", dt8852.state);
        },
        Commands::Download => {
            // Implement download logic
            println!("Download not fully implemented yet.");
        }
    }

    Ok(())
}
