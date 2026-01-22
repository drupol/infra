use std::fs::{OpenOptions, File};
use std::io::{Read, Write};
use std::os::fd::AsFd;
use std::time::Duration;
use crate::sysfs_scan::UsbDevice;
use crate::protocol::{parse_hid_data, parse_serial_data, SensorData};
use anyhow::{Result, Context, anyhow};
use nix::poll::{poll, PollFd, PollFlags};
use serde::Serialize;
use std::io::BufRead;

#[derive(Debug, Serialize)]
pub struct DeviceResult {
    #[serde(flatten)]
    pub device_info: UsbDevice,
    pub firmware: Option<String>,
    #[serde(flatten)]
    pub data: Option<SensorData>,
    pub error: Option<String>,
}

pub struct TemperDevice {
    pub device: UsbDevice,
    pub verbose: bool,
}

impl TemperDevice {
    pub fn new(device: UsbDevice, verbose: bool) -> Self {
        Self { device, verbose }
    }

    pub fn read(&self) -> DeviceResult {
        // Try the last device found in children
        if let Some(dev_name) = self.device.children.last() {
            if dev_name.starts_with("hidraw") {
                match self.read_hidraw(dev_name) {
                    Ok((fw, data)) => return DeviceResult {
                        device_info: self.device.clone(),
                        firmware: Some(fw),
                        data: Some(data),
                        error: None,
                    },
                    Err(e) => return DeviceResult {
                        device_info: self.device.clone(),
                        firmware: None,
                        data: None,
                        error: Some(format!("Error reading hidraw: {}", e)),
                    }
                }
            } else if dev_name.starts_with("tty") {
                match self.read_serial(dev_name) {
                     Ok((fw, data)) => return DeviceResult {
                        device_info: self.device.clone(),
                        firmware: Some(fw),
                        data: Some(data),
                        error: None,
                    },
                     Err(e) => return DeviceResult {
                        device_info: self.device.clone(),
                        firmware: None,
                        data: None,
                        error: Some(format!("Error reading serial: {}", e)),
                    }
                }
            }
        }
        
        DeviceResult {
            device_info: self.device.clone(),
            firmware: None,
            data: None,
            error: Some("No usable hid/tty devices available".to_string()),
        }
    }

    fn read_hidraw_firmware(&self, file: &mut File) -> Result<Vec<u8>> {
        let query = [0x01, 0x86, 0xff, 0x01, 0, 0, 0, 0];
        if self.verbose {
            println!("Firmware query: {}", hex::encode(query));
        }

        for _ in 0..10 {
            file.write_all(&query)?;

            let mut firmware = Vec::new();
            
            loop {
                // PollFd::new borrows file, so it must be momentary
                let fd_ref = file.as_fd();
                let mut poll_cds = [PollFd::new(&fd_ref, PollFlags::POLLIN)];
                let ret = poll(&mut poll_cds, 200)?; // 0.2s timeout
                if ret == 0 {
                    break;
                }
                let mut buf = [0u8; 8];
                let n = file.read(&mut buf)?;
                if n == 0 { break; }
                firmware.extend_from_slice(&buf[..n]);
                if firmware.len() > 8 {
                    break;
                }
            }
            
            if !firmware.is_empty() {
                if self.verbose {
                     println!("Firmware value: {} {:?}", hex::encode(&firmware), String::from_utf8_lossy(&firmware));
                }
                return Ok(firmware);
            }
        }
        
        Err(anyhow!("Cannot read device firmware identifier"))
    }

    fn read_hidraw(&self, dev_name: &str) -> Result<(String, SensorData)> {
        let path = format!("/dev/{}", dev_name);
        let mut file = OpenOptions::new().read(true).write(true).open(&path)
            .context(format!("Failed to open {}", path))?;
        
        let firmware_bytes = self.read_hidraw_firmware(&mut file)?;
        let firmware_str = String::from_utf8_lossy(&firmware_bytes).trim().to_string();

        // Get temperature/humidity
        let query = [0x01, 0x80, 0x33, 0x01, 0, 0, 0, 0];
        file.write_all(&query)?;

        let mut data_bytes = Vec::new();

        loop {
            let fd_ref = file.as_fd();
            let mut poll_cds = [PollFd::new(&fd_ref, PollFlags::POLLIN)];
            let ret = poll(&mut poll_cds, 100)?; // 0.1s timeout
            if ret == 0 {
                break;
            }
            let mut buf = [0u8; 8];
            let n = file.read(&mut buf)?;
            if n == 0 { break; }
            data_bytes.extend_from_slice(&buf[..n]);
        }
        
        if self.verbose {
            println!("Data value: {}", hex::encode(&data_bytes));
        }
        
        Ok(parse_hid_data(&firmware_str, &data_bytes))
    }

    fn read_serial(&self, dev_name: &str) -> Result<(String, SensorData)> {
        let path = format!("/dev/{}", dev_name);
        
        let mut port = serialport::new(&path, 9600)
            .data_bits(serialport::DataBits::Eight)
            .parity(serialport::Parity::None)
            .stop_bits(serialport::StopBits::One)
            .timeout(Duration::from_secs(1))
            .open()?;

        // Send "Version"
        port.write_all(b"Version")?;

        // Let's implement a helper to read line.
        let mut reader = std::io::BufReader::new(port.try_clone().context("Failed to clone port")?);
        
        let mut firmware_line = String::new();
        reader.read_line(&mut firmware_line)?;
        let firmware = firmware_line.trim().to_string();

        port.write_all(b"ReadTemp")?;
        let mut reply = String::new();
        reader.read_line(&mut reply)?;
        let mut reply2 = String::new();
        reader.read_line(&mut reply2)?;
        
        let full_reply = format!("{}{}", reply, reply2);
        
        Ok((firmware, parse_serial_data(&full_reply)))
    }
}
