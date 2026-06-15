{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.lxmd;
  settingsFormat = pkgs.master.formats.configobj { };

  inherit (lib)
    mkEnableOption
    mkOption
    mkPackageOption
    ;
in
{
  options = {
    services.lxmd = {
      enable = mkEnableOption "Enable lxmd";
      package = mkPackageOption pkgs [ "python3Packages" "lxmf" ] { };

      settings = lib.mkOption {
        type = lib.types.nullOr settingsFormat.type;
        default = null;
        description = "Structured lxmd configuration. The generated file is copied to the dataDir on service start. Use `lxmd --exampleconfig` to get an example config file.";
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
      };

      identityFile = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Path to lxmd identity file. This file will be copied to the stateDir on service start.";
      };

      extraGroups = mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Additional groups for the lxmd service user.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.lxmd = {
      description = "Reticulum Network Lightweight Extensible Message Format Daemon";
      after = lib.optionals config.services.rnsd.enable [ "rnsd.service" ];

      serviceConfig =
        let
          copyConfig = pkgs.writeShellApplication {
            name = "lxmd-copy-config-files";
            text =
              lib.optionalString (cfg.rnsd.settings != null) ''
                install -Dm400 ${settingsFormat.generate "rnsd.conf" cfg.rnsd.settings} "$STATE_DIRECTORY"/rnsd/config
              ''
              + lib.optionalString (cfg.rnsd.transportIdentityFile != null) ''
                install -Dm400 ${cfg.rnsd.transportIdentityFile} "$STATE_DIRECTORY"/rnsd/storage/transport_identity
              ''
              + lib.optionalString (cfg.settings != null) ''
                install -Dm400 ${settingsFormat.generate "lxmd.conf" cfg.settings} "$STATE_DIRECTORY"/lxmd/config
              ''
              + lib.optionalString (cfg.identityFile != null) ''
                install -Dm400 ${cfg.identityFile} "$STATE_DIRECTORY"/lxmd/identity
              '';
          };
        in
        {
          DynamicUser = true;
          StateDirectory = "lxmd";
          SupplementaryGroups = cfg.extraGroups;
          RuntimeDirectory = "lxmd";
          CacheDirectory = "lxmd";

          ExecStartPre = lib.getExe copyConfig;
          ExecStart = ''
            ${lib.getExe cfg.package} --verbose --config ''${STATE_DIRECTORY}/lxmd --rnsconfig ''${STATE_DIRECTORY}/rnsd
          '';
        };
    };
  };

  meta.maintainers = with lib.maintainers; [ drupol ];
}
