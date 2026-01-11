import serial
import sys
import argparse
from dt8852 import Dt8852
from influxdb_client import InfluxDBClient, Point, WritePrecision
from influxdb_client.client.write_api import SYNCHRONOUS


def parse_args():
    parser = argparse.ArgumentParser(description="Trotec SL400 Data Logger to InfluxDB")

    parser.add_argument(
        "--url", default="http://localhost:8086", required=True, help="InfluxDB URL"
    )
    parser.add_argument("--token", required=True, help="InfluxDB Token")
    parser.add_argument("--org", default="default", help="InfluxDB Organization")
    parser.add_argument("--bucket", default="default", help="InfluxDB Bucket")

    parser.add_argument(
        "--port", default="/dev/ttyUSB0", required=True, help="Serial port of the SL400"
    )
    parser.add_argument(
        "--baud", type=int, default=9600, help="Serial baud rate (default 9600)"
    )

    parser.add_argument(
        "--range",
        choices=["30-80", "50-100", "80-130", "30-130"],
        default="30-80",
        help="dB Range",
    )
    parser.add_argument(
        "--weighting",
        choices=["A", "C"],
        default="C",
        help="Frequency weighting: A (human) or C (raw)",
    )
    parser.add_argument(
        "--speed", choices=["FAST", "SLOW"], default="FAST", help="Response speed"
    )

    return parser.parse_args()


def draw_bar(val):
    safe_val = max(30, min(130, val))
    bar_length = int((safe_val - 30) / (130 - 30) * 50)
    bar = "█" * bar_length + "-" * (50 - bar_length)
    color = "\033[92m"  # Green
    if val > 75:
        color = "\033[93m"  # Yellow
    if val > 90:
        color = "\033[91m"  # Red
    sys.stdout.write(f"\r{color}{val:5.1f} dB [{bar}] \033[0m")
    sys.stdout.flush()


def main():
    args = parse_args()

    range_map = {
        "30-80": Dt8852.Range_mode.R_30_80,
        "50-100": Dt8852.Range_mode.R_50_100,
        "80-130": Dt8852.Range_mode.R_80_130,
        "30-130": Dt8852.Range_mode.R_30_130_AUTO,
    }
    weighting_map = {
        "A": Dt8852.Frequency_weighting.DBA,
        "C": Dt8852.Frequency_weighting.DBC,
    }
    speed_map = {
        "FAST": Dt8852.Time_weighting.FAST,
        "SLOW": Dt8852.Time_weighting.SLOW,
    }

    client = InfluxDBClient(url=args.url, token=args.token, org=args.org)
    write_api = client.write_api(write_options=SYNCHRONOUS)

    try:
        with serial.Serial(args.port, baudrate=args.baud, timeout=2) as sp:
            meter = Dt8852(sp)

            print(f"--- Noise Station Started: {args.port} ---")
            print(
                f"Config: Range={args.range}, Weighting=dB{args.weighting}, Speed={args.speed}"
            )

            modes = [
                range_map[args.range],
                speed_map[args.speed],
                weighting_map[args.weighting],
                Dt8852.Recording_mode.RECORDING,
            ]
            meter.set_mode(modes)

            for _ in meter.decode_next_token():
                if len(modes) == 0:
                    break

            print("\nLIVE MONITORING (Press Ctrl+C to stop and download memory)")
            print(f"Logging to Bucket: {args.bucket}")
            print("-" * 65)

            try:
                while True:
                    for token_type, token_value, _ in meter.decode_next_token():
                        if token_type == "current_spl":
                            val = float(token_value)
                            if val > 200:
                                val /= 10.0

                            draw_bar(val)

                            point = (
                                Point("noise_level")
                                .tag("type", "live")
                                .tag("weighting", args.weighting)
                                .field("decibels", val)
                            )
                            write_api.write(
                                bucket=args.bucket, org=args.org, record=point
                            )

            except KeyboardInterrupt:
                print("\n\n--- Monitoring Stopped. Starting Memory Dump ---")

            meter.set_mode([Dt8852.Recording_mode.NOT_RECORDING])
            print("Downloading stored history...")
            record_gen = meter.get_recordings()

            count = 0
            while True:
                try:
                    data = next(record_gen)
                    if isinstance(data, tuple) and data[0] == "sample":
                        _, val, ts, _ = data
                        val = float(val)
                        if val > 200:
                            val /= 10.0

                        if 20.0 <= val <= 140.0:
                            point = (
                                Point("noise_level")
                                .tag("type", "history")
                                .field("decibels", val)
                                .time(ts, WritePrecision.NS)
                            )
                            write_api.write(
                                bucket=args.bucket, org=args.org, record=point
                            )
                            count += 1
                            if count % 100 == 0:
                                print(f"  Downloaded {count} historical records...")
                except StopIteration:
                    print(f"Success: {count} historical records saved.")
                    break
                except Exception:
                    continue

    except Exception as e:
        print(f"\nConnection Error: {e}")
    finally:
        client.close()
        print("\nGoodbye!")


if __name__ == "__main__":
    main()
