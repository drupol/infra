{
  inputs,
  lib,
  ...
}:
{
  flake.modules.nixos.noise-station-client =
    { pkgs, ... }:
    {
      nixpkgs = {
        overlays = [
          inputs.self.overlays.default
        ];
      };

      users.groups.dialout.members = [ "telegraf" ];
      users.groups.plugdev.members = [ "telegraf" ];

      services =
        let
          temper-py-bin = lib.getExe (
            pkgs.writeShellApplication {
              name = "read-temper-bin";
              runtimeInputs = [ pkgs.local.temper-py ];
              text = ''
                ${lib.getExe pkgs.local.temper-py} --json
              '';
            }
          );
        in
        {
          udev.extraRules = ''
            KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="telegraf"
          '';
          telegraf = {
            enable = true;
            extraConfig = {
              inputs.exec = {
                commands = [
                  "${temper-py-bin}"
                ];
                interval = "60s";
                data_format = "json_v2";

                json_v2 = [
                  {
                    measurement_name = "usb_temperature";

                    object = [
                      {
                        path = "@this"; # '@this' refers to each element in the JSON array

                        tag = [
                          { path = "product"; }
                          { path = "port"; }
                          { path = "firmware"; }
                          { path = "vendorid"; }
                        ];

                        field = [
                          {
                            path = "internal temperature";
                            rename = "temp_internal";
                            type = "float";
                          }
                          {
                            path = "external temperature";
                            rename = "temp_external";
                            type = "float";
                          }
                        ];
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
}
