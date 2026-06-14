{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.nomadnet;
  inherit (lib)
    mkEnableOption
    mkOption
    mkPackageOption
    ;
in
{
  options = {
    services.nomadnet = {
      enable = mkEnableOption "Enable nomadnet";
      package = mkPackageOption pkgs "nomadnet" { };

      rnsdConfigFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to rnsd configuration file. This file will be copied to the stateDir on service start. Use `rnsd --exampleconfig` to get an example config file.";
      };

      configFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to nomadnet configuration file. This file will be copied to the stateDir on service start.";
      };

      identityFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to nomadnet identity file. This file will be copied to the stateDir on service start.";
      };

      extraGroups = mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Additional groups for the nomadnet service user.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.nomadnet = {
      description = "Reticulum Network Nomadnet Service";
      after = lib.optionals config.services.rnsd.enable [ "rnsd.service" ];

      serviceConfig =
        let
          copyConfig = pkgs.writeShellApplication {
            name = "nomadnet-copy-config-files";
            text = lib.optionalString (cfg.rnsdConfigFile != null) ''
                install -Dm400 ${cfg.rnsdConfigFile} "$STATE_DIRECTORY"/rnsd/config
              '' +
              lib.optionalString (cfg.configFile != null) ''
                install -Dm400 ${cfg.configFile} "$STATE_DIRECTORY"/nomadnet/config
              ''
              + lib.optionalString (cfg.identityFile != null) ''
                install -Dm400 ${cfg.identityFile} "$STATE_DIRECTORY"/nomadnet/identity
              '';
          };
        in
        {
          DynamicUser = true;
          StateDirectory = "nomadnet";
          SupplementaryGroups = cfg.extraGroups;
          RuntimeDirectory = "nomadnet";
          CacheDirectory = "nomadnet";

          ExecStartPre = lib.getExe copyConfig;
          ExecStart = ''
            ${lib.getExe cfg.package} --daemon --console --config ''${STATE_DIRECTORY}/nomadnet --rnsconfig ''${STATE_DIRECTORY}/rnsd
          '';
        };
    };
  };

  meta.maintainers = with lib.maintainers; [ drupol ];
}
