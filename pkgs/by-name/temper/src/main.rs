use clap::Parser;
use std::collections::HashMap;

mod sysfs_scan;
mod device;
mod protocol;

use sysfs_scan::get_usb_devices;
use device::TemperDevice;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// List all USB devices
    #[arg(short, long)]
    list: bool,

    /// Provide output as JSON
    #[arg(long)]
    json: bool,

    /// Force the use of the hex id; ignore other ids (VENDOR_ID:PRODUCT_ID)
    #[arg(long)]
    force: Option<String>,

    /// Output binary data from thermometer
    #[arg(long)]
    verbose: bool,
}

fn is_known_id(vendor_id: u16, product_id: u16, forced: Option<(u16, u16)>) -> bool {
    if let Some((f_vid, f_pid)) = forced {
        return vendor_id == f_vid && product_id == f_pid;
    }

    match (vendor_id, product_id) {
        (0x0c45, 0x7401) => true,
        (0x0c45, 0x7402) => true,
        (0x413d, 0x2107) => true,
        (0x1a86, 0x5523) => true,
        (0x1a86, 0xe025) => true,
        (0x3553, 0xa001) => true,
        _ => false,
    }
}

fn format_temp(val: Option<f32>) -> String {
    match val {
        Some(c) => format!("{:.2}C {:.2}F", c, c * 1.8 + 32.0),
        None => "- -".to_string(),
    }
}

fn format_hum(val: Option<f32>) -> String {
    match val {
        Some(h) => format!("{}%", h as i32),
        None => "-".to_string(),
    }
}

fn main() -> anyhow::Result<()> {
    let args = Args::parse();

    let forced_id = if let Some(s) = args.force {
        let parts: Vec<&str> = s.split(':').collect();
        if parts.len() != 2 {
            eprintln!("Cannot parse hexadecimal id: {}", s);
            std::process::exit(1);
        }
        let vid = u16::from_str_radix(parts[0], 16).map_err(|_| anyhow::anyhow!("Invalid Vendor ID"))?;
        let pid = u16::from_str_radix(parts[1], 16).map_err(|_| anyhow::anyhow!("Invalid Product ID"))?;
        Some((vid, pid))
    } else {
        None
    };

    let devices = get_usb_devices()?;

    if args.list {
        if args.json {
            // Replicate structure: dict indexed by path? 
            let mut map = HashMap::new();
            for dev in devices {
                map.insert(dev.path.to_string_lossy().to_string(), dev);
            }
            println!("{}", serde_json::to_string_pretty(&map)?);
        } else {
            for dev in devices {
                let known = if is_known_id(dev.vendor_id, dev.product_id, None) { "*" } else { " " };
                let children = if dev.children.is_empty() { "".to_string() } else { format!("{:?}", dev.children) };
                println!("Bus {:03} Dev {:03} {:04x}:{:04x} {} {} {} {}", 
                    dev.bus_num, dev.dev_num, dev.vendor_id, dev.product_id, known, 
                    dev.product.clone().unwrap_or("???".to_string()), 
                    dev.manufacturer.clone().unwrap_or("".to_string()),
                    children
                );
            }
        }
        return Ok(());
    }

    let mut results = Vec::new();

    for dev in devices {
        if !is_known_id(dev.vendor_id, dev.product_id, forced_id) {
            continue;
        }
        
        let temper = TemperDevice::new(dev, args.verbose);
        let res = temper.read();
        results.push(res);
    }

    if args.json {
        println!("{}", serde_json::to_string_pretty(&results)?);
    } else {
        for res in results {
             let mut s = format!("Bus {:03} Dev {:03} {:04x}:{:04x} {}", 
                res.device_info.bus_num, res.device_info.dev_num, 
                res.device_info.vendor_id, res.device_info.product_id,
                res.firmware.clone().unwrap_or("".to_string()));
            
            if let Some(err) = res.error {
                s += &format!(" Error: {}", err);
            } else if let Some(data) = res.data {
                s += &format!(" {}", format_temp(data.internal_temperature));
                s += &format!(" {}", format_hum(data.internal_humidity));
                s += &format!(" {}", format_temp(data.external_temperature));
                s += &format!(" {}", format_hum(data.external_humidity));
            }
            println!("{}", s);
        }
    }

    Ok(())
}
