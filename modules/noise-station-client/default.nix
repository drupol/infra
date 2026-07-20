{
  lib,
  inputs,
  ...
}:
{
  den.aspects.noise-station-client = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.local.temper ];

        nixpkgs = {
          overlays = [
            inputs.self.overlays.default
          ];
        };

        services = {
          telegraf =
            let
              temper-script = lib.getExe (
                pkgs.writeShellApplication {
                  name = "temper-script";

                  runtimeInputs = [
                    pkgs.local.temper
                    pkgs.jq
                  ];

                  text = ''
                    ${lib.getExe pkgs.local.temper} --json --force 3553:a001 | jq '.[0]'
                  '';
                }
              );
            in
            {
              enable = true;

              extraConfig = {
                agent = {
                  ## Maximum number of unwritten metrics per output.  Increasing this value
                  ## allows for longer periods of output downtime without dropping metrics at the
                  ## cost of higher maximum memory usage.
                  metric_buffer_limit = 20000;
                };

                inputs = {
                  exec = {
                    commands = [
                      temper-script
                    ];

                    data_format = "json_v2";

                    json_v2 = [
                      {
                        field = [
                          {
                            path = "internal_temperature";
                            rename = "temp_internal";
                            type = "float";
                          }
                          {
                            path = "external_temperature";
                            rename = "temp_external";
                            type = "float";
                          }
                        ];

                        measurement_name = "usb_temperature";

                        tag = [
                          { path = "product_id"; }
                          { path = "path"; }
                          { path = "vendor_id"; }
                          { path = "firmware"; }
                        ];
                      }
                    ];
                  };

                  execd = {
                    command = [
                      "${lib.getExe pkgs.local.dt8852}"
                      "live"
                      "--range"
                      "R_30_80"
                      "--freqweighting"
                      "dba"
                      "--timeweighting"
                      "slow"
                      "--format"
                      "telegraf"
                      "-v"
                    ];

                    signal = "none";
                  };
                };

                outputs.influxdb_v2 = [
                  {
                    bucket = "default";
                    namedrop = [ "usb_temperature" ];
                    organization = "default";
                    token = "noisestation";
                    urls = [ "http://192.168.2.116:8086" ];
                  }
                  {
                    bucket = "usb_temperature";
                    namepass = [ "usb_temperature" ];
                    organization = "default";
                    token = "noisestation";
                    urls = [ "http://192.168.2.116:8086" ];
                  }
                ];
              };
            };

          udev.extraRules = ''
            KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="telegraf"
          '';
        };

        users = {
          groups = {
            dialout.members = [ "telegraf" ];
            plugdev.members = [ "telegraf" ];
          };
        };
      };
  };
}
