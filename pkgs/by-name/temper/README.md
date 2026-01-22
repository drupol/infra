# TEMPer Rust

A Rust implementation of the [temper.py](https://github.com/urwen/temper) tool.
This CLI utility interfaces with various USB TEMPer thermometers and hygrometers
to read temperature and humidity data.

## Purpose

This tool is designed to read environmental data from TEMPer USB devices on
Linux systems. It supports reading from both HIDRaw and Serial (TTY) interfaces
and can output data in human-readable text or JSON format.

## Supported Devices

The tool supports devices with the following Vendor/Product IDs:

- **0c45:7401**
- **0c45:7402**
- **413d:2107**
- **1a86:5523**
- **1a86:e025**
- **3553:a001**

Supported Firmware Versions:

- TEMPerF1.2, TEMPerF1.4, TEMPer1F1.
- TEMPerGold_V3.1, V3.3, V3.4, V3.5
- TEMPerX_V3.1, V3.3
- TEMPer2_M12_V1.3
- TEMPer2_V3.7, V3.9
- TEMPerHUM_V3.9
- TEMPer1F_H1V1.5F (SHT20 sensors)
- TEMPer2_V4.1
- TEMPer1F_V3.9, V4.1

## Requirements

- Linux OS (uses `/sys/bus/usb/devices` for enumeration)
- Read permissions on `/dev/hidraw*` or `/dev/tty*` devices (commonly requires adding your user to a specific group or udev rules).

## Usage

### List Devices

List all detected USB devices and identify known TEMPer devices:

```bash
cargo run -- --list
# Or with JSON output
cargo run -- --list --json
```

### Read Temperature/Humidity

Read the sensor data from the first detected supported device:

```bash
cargo run
```

_Note: You may need `sudo` if your user does not have permissions to read from the device._

### Options

```text
  -l, --list           List all USB devices
      --json           Provide output as JSON
      --force <VID:PID>  Force the use of the hex id; ignore other ids
      --verbose        Output binary data from thermometer
  -h, --help           Print help
```

## Build

```bash
cargo build --release
```

The binary will be located at `target/release/temper`.
