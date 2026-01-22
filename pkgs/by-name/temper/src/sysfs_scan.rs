use std::fs;
use std::path::{Path, PathBuf};
use anyhow::Result;

use serde::Serialize;

#[derive(Debug, Clone, Serialize)]
pub struct UsbDevice {
    pub path: PathBuf,
    pub vendor_id: u16,
    pub product_id: u16,
    pub manufacturer: Option<String>,
    pub product: Option<String>,
    pub bus_num: u32,
    pub dev_num: u32,
    pub children: Vec<String>, // tty or hidraw names
}

const SYSPATH: &str = "/sys/bus/usb/devices";

fn read_file(path: &Path) -> Option<String> {
    fs::read_to_string(path).ok().map(|s| s.trim().to_string())
}

fn find_devices(dirname: &Path) -> Vec<String> {
    let mut devices = Vec::new();
    if let Ok(entries) = fs::read_dir(dirname) {
        for entry in entries.flatten() {
            let path = entry.path();
            let name = entry.file_name().to_string_lossy().to_string();

            if path.is_dir() && !path.symlink_metadata().map(|m| m.file_type().is_symlink()).unwrap_or(true) {
                devices.extend(find_devices(&path));
            }
            
            if name.starts_with("tty") && name.chars().last().map_or(false, |c| c.is_ascii_digit()) {
                 devices.push(name.clone());
            }
            if name.starts_with("hidraw") && name.chars().last().map_or(false, |c| c.is_ascii_digit()) {
                devices.push(name);
            }
        }
    }
    devices
}

fn get_usb_device(dirname: &Path) -> Result<Option<UsbDevice>> {
    let vid_str = match read_file(&dirname.join("idVendor")) {
        Some(s) => s,
        None => return Ok(None),
    };
    let pid_str = match read_file(&dirname.join("idProduct")) {
        Some(s) => s,
        None => return Ok(None),
    };

    let vendor_id = u16::from_str_radix(&vid_str, 16)?;
    let product_id = u16::from_str_radix(&pid_str, 16)?;
    
    let manufacturer = read_file(&dirname.join("manufacturer"));
    let product = read_file(&dirname.join("product"));
    
    let bus_num = read_file(&dirname.join("busnum"))
        .and_then(|s| s.parse().ok())
        .unwrap_or(0);
    let dev_num = read_file(&dirname.join("devnum"))
        .and_then(|s| s.parse().ok())
        .unwrap_or(0);

    let mut children = find_devices(dirname);
    children.sort();
    children.dedup();

    Ok(Some(UsbDevice {
        path: dirname.to_path_buf(),
        vendor_id,
        product_id,
        manufacturer,
        product,
        bus_num,
        dev_num,
        children,
    }))
}

pub fn get_usb_devices() -> Result<Vec<UsbDevice>> {
    let mut devices = Vec::new();
    if let Ok(entries) = fs::read_dir(SYSPATH) {
        for entry in entries.flatten() {
            let path = entry.path();
            if path.is_dir() {
                if let Ok(Some(dev)) = get_usb_device(&path) {
                    devices.push(dev);
                }
            }
        }
    }
    devices.sort_by_key(|d| d.bus_num * 1000 + d.dev_num);
    Ok(devices)
}
