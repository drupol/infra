{
  inputs,
  lib,
  ...
}:
{
  flake.modules = {
    nixos.noise-station-client =
      { pkgs, ... }:
      {
        nixpkgs = {
          overlays = [
            inputs.self.overlays.default
          ];
        };

        environment.systemPackages = [ pkgs.local.temper ];

        users.groups.dialout.members = [ "telegraf" ];
        users.groups.plugdev.members = [ "telegraf" ];

        services = {
          udev.extraRules = ''
            KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="telegraf"
          '';
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
                inputs.exec = {
                  commands = [
                    temper-script
                  ];
                  data_format = "json_v2";

                  json_v2 = [
                    {
                      measurement_name = "usb_temperature";

                      tag = [
                        { path = "product_id"; }
                        { path = "path"; }
                        { path = "vendor_id"; }
                        { path = "firmware"; }
                      ];

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
                    }
                  ];
                };

                inputs.execd = {
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

                outputs.influxdb_v2 = [
                  {
                    urls = [ "http://192.168.2.116:8086" ];
                    token = "noisestation";
                    organization = "default";
                    bucket = "default";
                    namedrop = [ "usb_temperature" ];
                  }
                  {
                    urls = [ "http://192.168.2.116:8086" ];
                    token = "noisestation";
                    organization = "default";
                    bucket = "usb_temperature";
                    namepass = [ "usb_temperature" ];
                  }
                ];
              };
            };
        };
      };
  };
}
