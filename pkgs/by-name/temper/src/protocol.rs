use byteorder::{BigEndian, ByteOrder};
use serde::Serialize;
use regex::Regex;

#[derive(Debug, Serialize, Default, Clone)]
pub struct SensorData {
    pub internal_temperature: Option<f32>,
    pub internal_humidity: Option<f32>,
    pub external_temperature: Option<f32>,
    pub external_humidity: Option<f32>,
}

fn parse_bytes(offset: usize, divisor: f32, bytes: &[u8]) -> Option<f32> {
    if bytes.len() <= offset + 1 {
        return None;
    }
    // Check validity
    if bytes[offset] == 0x4e && bytes[offset + 1] == 0x20 {
        return None;
    }

    let val = BigEndian::read_i16(&bytes[offset..offset + 2]);
    Some(val as f32 / divisor)
}

pub fn parse_hid_data(firmware: &str, bytes: &[u8]) -> (String, SensorData) {
    let mut data = SensorData::default();
    let mut fw = firmware.to_string();

    if firmware.starts_with("TEMPerF1.2") || firmware.starts_with("TEMPerF1.4") || firmware.starts_with("TEMPer1F1.") {
        fw = firmware[..10].to_string();
        data.internal_temperature = parse_bytes(2, 256.0, bytes);
        return (fw, data);
    }

    if firmware.starts_with("TEMPerGold_V3.1") || firmware.starts_with("TEMPerGold_V3.3") || 
       firmware.starts_with("TEMPerGold_V3.4") || firmware.starts_with("TEMPerGold_V3.5") {
        fw = firmware[..15].to_string();
        data.internal_temperature = parse_bytes(2, 100.0, bytes);
        return (fw, data);
    }

    if firmware.starts_with("TEMPerX_V3.1") || firmware.starts_with("TEMPerX_V3.3") {
        fw = firmware[..12].to_string();
        data.internal_temperature = parse_bytes(2, 100.0, bytes);
        data.internal_humidity = parse_bytes(4, 100.0, bytes);
        data.external_temperature = parse_bytes(10, 100.0, bytes);
        data.external_humidity = parse_bytes(12, 100.0, bytes);
        return (fw, data);
    }

    if firmware.starts_with("TEMPer2_M12_V1.3") {
        fw = firmware[..16].to_string();
        data.internal_temperature = parse_bytes(2, 256.0, bytes);
        data.external_temperature = parse_bytes(4, 256.0, bytes);
        return (fw, data);
    }

   if firmware.starts_with("TEMPer2_V3.7") || firmware.starts_with("TEMPer2_V3.9") {
        fw = firmware[..12].to_string();
        data.internal_temperature = parse_bytes(2, 100.0, bytes);
        data.external_temperature = parse_bytes(10, 100.0, bytes);
        return (fw, data);
    }

    if firmware.starts_with("TEMPerHUM_V3.9") {
        fw = firmware[..14].to_string();
        data.internal_temperature = parse_bytes(2, 100.0, bytes);
        data.external_temperature = parse_bytes(10, 100.0, bytes);
        data.internal_humidity = parse_bytes(4, 100.0, bytes);
        return (fw, data);
    }

    if firmware.starts_with("TEMPer1F_H1V1.5F") {
        fw = firmware[..16].to_string();
        // Special case SHT20
        // Special case SHT20
        if let Some(raw_t) = parse_bytes(2, 1.0, bytes) {
             let t_int = (raw_t as i32) << 2;
             data.internal_temperature = Some(-46.85 + 175.72 * (t_int as f32) / 65536.0);
        }
        if let Some(raw_h) = parse_bytes(4, 1.0, bytes) {
            let h_int = (raw_h as i32) << 4;
            data.internal_humidity = Some(-6.0 + 125.0 * (h_int as f32) / 65536.0);
        }
        return (fw, data);
    }
    
    if firmware.starts_with("TEMPer2_V4.1") {
        fw = firmware[..12].to_string();
        data.internal_temperature = parse_bytes(2, 100.0, bytes);
        data.external_temperature = parse_bytes(10, 100.0, bytes);
        return (fw, data);
    }

    if firmware.starts_with("TEMPer1F_V3.9") || firmware.starts_with("TEMPer1F_V4.1") {
        fw = firmware[..13].to_string();
        data.internal_temperature = parse_bytes(2, 100.0, bytes);
        return (fw, data);
    }

    (fw, data)
}

pub fn parse_serial_data(reply: &str) -> SensorData {
    let mut data = SensorData::default();
    
    // Regex: r'Temp-Inner:(-?[0-9.]+).*, ?(-?[0-9.\-]*)'
    let re_inner = Regex::new(r"Temp-Inner:(-?[0-9.]+).*, ?(-?[0-9.\-]*)").unwrap();
    if let Some(caps) = re_inner.captures(reply) {
        if let Some(m) = caps.get(1) {
            data.internal_temperature = m.as_str().parse().ok();
        }
        if let Some(m) = caps.get(2) {
            data.internal_humidity = m.as_str().parse().ok();
        }
    }

    // Regex: r'Temp-Outer:(-?[0-9.]+).*?, ?(-?[0-9.\-]*)'
    let re_outer = Regex::new(r"Temp-Outer:(-?[0-9.]+).*?, ?(-?[0-9.\-]*)").unwrap();
    if let Some(caps) = re_outer.captures(reply) {
        if let Some(m) = caps.get(1) {
            data.external_temperature = m.as_str().parse().ok();
        }
        if let Some(m) = caps.get(2) {
            data.external_humidity = m.as_str().parse().ok();
        }
    }
    
    data
}
