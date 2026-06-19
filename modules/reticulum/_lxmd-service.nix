{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.lxmd;
  settingsFormat = pkgs.master.formats.configobj { };
in
{
  options = {
    services.lxmd = {
      enable = lib.mkEnableOption "Enable Reticulum Network Lightweight Extensible Message Format Daemon (lxmd)";
      package = lib.mkPackageOption pkgs "lxmf" { };

      settings = lib.mkOption {
        type = lib.types.nullOr settingsFormat.type;
        default = null;
        description = "Structured lxmd configuration. The generated file is copied to the dataDir on service start. Use `lxmd --exampleconfig` to get an example config file.";
      };

      identityFile = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Path to lxmd identity file. This file will be copied to the stateDir on service start.";
      };

      rnsd = {
        settings = lib.mkOption {
          type = lib.types.nullOr settingsFormat.type;
          default = null;
          description = "Structured rnsd configuration. The generated file is copied to the dataDir on service start. Use `rnsd --exampleconfig` to get an example config file.";
        };

        transportIdentityFile = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Path to rnsd identity file. This file will be copied to the dataDir on service start.";
        };

        identities = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          default = { };
          description = "Map of identity names to paths of identity files.";
        };
      };

      extraGroups = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Additional groups for the lxmd service user.";
      };

      healthCheck = {
        enable = lib.mkEnableOption "wait for lxmd to become healthy after startup";

        intervalSeconds = lib.mkOption {
          type = lib.types.ints.positive;
          default = 2;
          description = "Delay in seconds between each `lxmd --status` health check attempt.";
        };

        timeoutSeconds = lib.mkOption {
          type = lib.types.ints.positive;
          default = 120;
          description = "Maximum time in seconds to wait for `lxmd --status` to succeed during startup.";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.lxmd = {
      description = "Reticulum Network Lightweight Extensible Message Format Daemon";
      wantedBy = [ "multi-user.target" ];
      after = lib.optionals config.services.rnsd.enable [ "rnsd.service" ];
      wants = lib.optionals config.services.rnsd.enable [ "rnsd.service" ];

      preStart =
        let
          copySettings = lib.optionalString (cfg.settings != null) ''
            install -Dm600 ${settingsFormat.generate "lxmd.conf" cfg.settings} "$STATE_DIRECTORY"/lxmd/config
          '';
          copyIdentity = lib.optionalString (cfg.identityFile != null) ''
            install -Dm600 ${cfg.identityFile} "$STATE_DIRECTORY"/lxmd/identity
          '';
          copyRnsdSettings = lib.optionalString (cfg.rnsd.settings != null) ''
            install -Dm600 ${settingsFormat.generate "rnsd.conf" cfg.rnsd.settings} "$STATE_DIRECTORY"/rnsd/config
          '';
          copyRnsdTransportIdentity = lib.optionalString (cfg.rnsd.transportIdentityFile != null) ''
            install -Dm600 ${cfg.rnsd.transportIdentityFile} "$STATE_DIRECTORY"/rnsd/storage/transport_identity
          '';
          copyRnsdIdentities = lib.concatStringsSep "\n" (
            lib.mapAttrsToList (name: file: ''
              install -Dm600 ${file} "$STATE_DIRECTORY"/rnsd/storage/identities/${name}
            '') cfg.rnsd.identities
          );
        in
        copyRnsdSettings + copyRnsdTransportIdentity + copySettings + copyIdentity + copyRnsdIdentities;

      serviceConfig =
        let
          waitForHealthy = pkgs.writeShellApplication {
            name = "lxmd-wait-for-health";
            runtimeInputs = [ cfg.package ];
            text = ''
              deadline=$((SECONDS + ${toString cfg.healthCheck.timeoutSeconds}))

              until ${lib.getExe cfg.package} --status --config "$STATE_DIRECTORY"/lxmd --rnsconfig "$STATE_DIRECTORY"/rnsd >/dev/null 2>&1; do
                if [ "$SECONDS" -ge "$deadline" ]; then
                  echo "lxmd did not become healthy before timeout (${toString cfg.healthCheck.timeoutSeconds}s)" >&2
                  exit 1
                fi

                sleep ${toString cfg.healthCheck.intervalSeconds}
              done
            '';
          };
        in
        {
          DynamicUser = true;
          StateDirectory = "lxmd";
          SupplementaryGroups = cfg.extraGroups;
          RuntimeDirectory = "lxmd";
          CacheDirectory = "lxmd";
          ProtectSystem = "strict";

          ExecStart = ''
            ${lib.getExe cfg.package} --verbose --config ''${STATE_DIRECTORY}/lxmd --rnsconfig ''${STATE_DIRECTORY}/rnsd
          '';
        }
        // lib.optionalAttrs cfg.healthCheck.enable {
          ExecStartPost = lib.getExe waitForHealthy;
          TimeoutStartSec = cfg.healthCheck.timeoutSeconds + 5;
        };
    };
  };

  meta = {
    maintainers = with lib.maintainers; [ drupol ];
  };
}
