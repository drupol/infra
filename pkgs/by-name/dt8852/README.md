# dt8852

dt8852 is a cross-platform Rust crate and CLI tool for reading and controlling CEM DT-8852 and equivalent Sound Level Meter and Data Logger devices.

# Features

- Read current SPL value as measured from device.
- Read current device configuration.
- Configure the device.
- Download recorded sessions directly to .csv.
- Can be used directly from the command line interface, and in your own application using the API.

# Compatible devices

- [CEM DT-8852](http://www.cem-instruments.com/en/Product/detail/id/1294) (OEM)

This device is also re-branded and sold as:

- [Trotec SL400](https://en.trotec.com/shop/sl400-sound-level-meter.html)
- [Voltcraft SL-451](https://www.conrad.com/en/p/voltcraft-sl-451-sound-level-meter-and-data-logger-31-5-hz-8-khz-105031.html)
- ATP SL-8852
- ... probably various others.

The CEM DT-8851 lacks the data recording functionality, but might otherwise be
supported as well. However, due to availability of only a Trotec SL400, the
package is only tested on this device.

# Installation and running

## Install using Cargo

You can install the tool directly using `cargo`:

```shell
cargo install dt8852
```

## Build from source

Clone the repository and build using Cargo:

```shell
git clone <repository_url>
cd dt8852
cargo build --release
```

The binary will be available in `target/release/dt8852`.

## Device driver installation

The device internally uses a USB-to-UART bridge by Silicon Labs. Your OS needs a driver for this to work, so the device can be accessed as a regular RS232 serial (COM) device.

- On **Linux**, the driver (`cp210x`) is already available on many
  distributions. No action is needed. However, a user might need permission to
  access serial interfaces (e.g.: your user needs to be part of the `dialout`
  group). On Ubuntu and Debian you can add yourself to this group using
  `sudo usermod -a -G dialout $USER`. Others may vary.
- On **Windows 10**, the device is automatically recognized, and Windows
  installs the appropriate driver. No action is needed. Alternatively, if you
  already have installed the provided software, no action is needed. If needed,
  the USB driver is available directly from
  [Silicon Labs](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers).
- On **macOS**, a USB driver is available from
  [Silicon Labs](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers).

# Usage

## Command line interface

The typical usage of the command line tool:

```shell
dt8852 <MODE> [OPTIONS]
```

Where `<MODE>` is one of:

- `live`: get live SPL measurements from device, output to stdout.
- `set-mode`: configure device according to specified values and exits.
- `get-mode`: retrieve current device configuration and exit.
- `download`: to download recorded sessions as comma separated value (CSV) files and exit.

Use `dt8852 --help` for basic help, or `dt8852 MODE --help` for mode-specific help.

Note: by default the serial interface used is `/dev/ttyUSB0` (Linux/macOS) or `COM3` (Windows).
You can override this by using the `--serial-port` argument.

### Examples

#### Basic live output

```bash
$ dt8852 live
33.3
32.4
32.9
71.8
```

#### Verbose output

Use `-v` flags to increase verbosity (up to 5 times).

```bash
$ dt8852 live -v
2020-10-01 22:27:02.806050,37.3
2020-10-01 22:27:03.304626,33.0
```

#### Get current configuration

```bash
$ dt8852 get-mode
current_time = 22:31:39
current_spl = 40.7dB
frequency_weighting = dB(A)
time_weighting = Fast
...
```

#### Set configuration

Sets modes Range 30dB - 80dB, dB(C), slow, and starts recording to internal storage.

```bash
$ dt8852 set-mode --range R_30_80 --freqweighting DBC --timeweighting SLOW --record RECORDING
```

#### Stop recording

```bash
$ dt8852 set-mode --record NOT_RECORDING
```

#### Download recordings

**Note:** make sure the device is not recording anymore before downloading, otherwise memory corruption will occur.

```bash
$ dt8852 download
```

This will save CSV files to the current directory.

## API

The crate can be used in your own Rust applications.

### Add dependency

Add `dt8852` to your `Cargo.toml`:

```toml
[dependencies]
dt8852 = "0.1"
serialport = "4.0"
```

# Troubleshooting

##  The clock problem

Besides the 9V battery, these devices contain a lithium cell to keep the clock
running when powered off. When this cell runs out, the clock stops at `00:00:00`.

You can replace the lithium cell (typically CR1220) by opening the device.

After replacing the cell, if the clock is still frozen:

1. Power on the device while keeping the `Setup` button pressed.
2. Repeatedly press `Setup` until `rSt` is shown.
3. Press `HOLD`.

The device will reset the date and time.

# Attribution

This project is a port of the
[original Python project](https://codeberg.org/randysimons/dt8852) by
**Randy Simons**, ported to Rust with the help of **Antigravity (Gemini)**.

The project is based on information from the
[Sigrok device wiki for CEM DT-8852](https://sigrok.org/wiki/CEM_DT-8852).
