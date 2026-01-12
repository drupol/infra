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

      services = {
        telegraf = {
          enable = true;
          extraConfig = {
            inputs.execd = {
              command = [
                "${lib.getExe pkgs.local.dt8852}"
                "live"
                "--range"
                "R_30_80"
                "--freqweighting"
                "dbc"
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
