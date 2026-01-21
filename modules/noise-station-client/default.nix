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
            pkgs.writeScriptBin "read-temper.sh" ''
              ${lib.getExe pkgs.local.temper-py} --json
            ''
          );
        in
        {
          telegraf = {
            enable = true;
            extraConfig = {
              inputs.exec = {
                commands = [
                  "${temper-py-bin}"
                ];
                data_format = "json";
                interval = "60s";
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
              outputs.influxdb_v2 = {
                urls = [ "http://192.168.2.116:8086" ];
                token = "noisestation";
                organization = "default";
                bucket = "default";
              };
            };
          };
        };
    };
}
