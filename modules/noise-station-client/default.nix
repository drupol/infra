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
              urls = [ "http://localhost:8086" ];
              token = "Kms5hykJ0y1eaRQpEAWKJVwprgu4mhitElYiW49p2-ip1W9BQMHUelB9VQ8SfkSbQaoyTheADgOh906aH1oNdg==";
              organization = "default";
              bucket = "default";
            };
          };
        };
      };
    };
}
