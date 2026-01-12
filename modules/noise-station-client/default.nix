{ lib, ... }:
{
  flake.modules.nixos.noise-station-client =
    { pkgs, ... }:
    {
      users.groups.dialout.members = [ "telegraf" ];

      services = {
        telegraf = {
          enable = true;
          extraConfig = {
            inputs.execd = {
              command = [
                "${lib.getExe pkgs.local.dt8852}"
                "live"
                "--format"
                "telegraf"
                "-vv"
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
