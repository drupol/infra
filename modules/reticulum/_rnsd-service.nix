{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.rnsd;
  inherit (lib)
    mkEnableOption
    mkOption
    mkPackageOption
    ;
in
{
  options = {
    services.rnsd = {
      enable = mkEnableOption "Enable rnsd";
      package = mkPackageOption pkgs "rns" { };

      configFile = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Path to rnsd configuration file. This file will be copied to the dataDir on service start. Use `rnsd --exampleconfig` to get an example config file.";
      };

      transportIdentityFile = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Path to rnsd identity file. This file will be copied to the dataDir on service start.";
      };

      extraGroups = mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Additional groups for the rnsd service user. E.g., add the `dialout` group to allow rnsd to access serial devices (e.g., `/dev/ttyACM0`).";
      };

      healthCheck = {
        enable = mkEnableOption "wait for rnsd to become healthy after startup";

        intervalSeconds = mkOption {
          type = lib.types.ints.positive;
          default = 2;
          description = "Delay in seconds between each `rnstatus` health check attempt.";
        };

        timeoutSeconds = mkOption {
          type = lib.types.ints.positive;
          default = 120;
          description = "Maximum time in seconds to wait for `rnstatus` to succeed during startup.";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.rnsd = {
      description = "Reticulum Network Stack Daemon";
      wantedBy = [ "multi-user.target" ];
      after = [
        "network.target"
      ];

      serviceConfig =
        let
          copyConfig = pkgs.writeShellApplication {
            name = "rnsd-copy-config-files";
            text =
              lib.optionalString (cfg.configFile != null) ''
                install -Dm400 ${cfg.configFile} "$STATE_DIRECTORY"/config
              ''
              + lib.optionalString (cfg.transportIdentityFile != null) ''
                install -Dm400 ${cfg.transportIdentityFile} "$STATE_DIRECTORY"/storage/transport_identity
              '';
          };

          waitForHealthy = pkgs.writeShellApplication {
            name = "rnsd-wait-for-health";
            text = ''
              deadline=$((SECONDS + ${toString cfg.healthCheck.timeoutSeconds}))

              until ${cfg.package}/bin/rnstatus >/dev/null 2>&1; do
                if [ "$SECONDS" -ge "$deadline" ]; then
                  echo "rnsd did not become healthy before timeout (${toString cfg.healthCheck.timeoutSeconds}s)" >&2
                  exit 1
                fi

                sleep ${toString cfg.healthCheck.intervalSeconds}
              done
            '';
          };
        in
        {
          DynamicUser = true;
          StateDirectory = "rnsd";
          SupplementaryGroups = cfg.extraGroups;
          RuntimeDirectory = "rnsd";
          CacheDirectory = "rnsd";

          ExecStartPre = lib.getExe copyConfig;
          ExecStart = "${cfg.package}/bin/rnsd --verbose --config $STATE_DIRECTORY";
        }
        // lib.optionalAttrs cfg.healthCheck.enable {
          ExecStartPost = lib.getExe waitForHealthy;
          TimeoutStartSec = cfg.healthCheck.timeoutSeconds + 5;
        };
    };
  };

  meta.maintainers = with lib.maintainers; [ drupol ];
}
