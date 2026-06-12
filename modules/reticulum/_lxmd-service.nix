{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.lxmd;
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

      user = mkOption {
        type =
          with lib.types;
          oneOf [
            str
            int
          ];
        default = "lxmd";
        description = "The user lxmd will run as.";
      };

      group = mkOption {
        type =
          with lib.types;
          oneOf [
            str
            int
          ];
        default = "reticulum";
        description = "The group lxmd will run with.";
      };

      dataDir = mkOption {
        type = lib.types.path;
        default = "/var/lib/reticulum/lxmf";
        description = "Path for lxmd state directory.";
      };

      configFile = lib.mkOption {
        type = lib.types.path;
        description = "Path to lxmd configuration file. This file will be copied to the dataDir on service start.";
      };

      identityFile = lib.mkOption {
        type = lib.types.path;
        description = "Path to lxmd identity file. This file will be copied to the dataDir on service start.";
      };

      extraGroups = mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Additional groups for the lxmd service user.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users.groups.${cfg.group} = { };
    users.users.${cfg.user} = {
      inherit (cfg) group;
      description = "lxmd user";
      isSystemUser = true;
      home = cfg.dataDir;
      createHome = true;
    };

    systemd.services.lxmd = {
      enable = true;
      description = "Reticulum Network Lightweight Extensible Message Format Daemon";
      after = lib.optionals config.services.rnsd.enable [ "rnsd.service" ];
      wants = lib.optionals config.services.rnsd.enable [ "rnsd.service" ];

      environment = {
        HOME = cfg.dataDir;
      };

      preStart = ''
        mkdir -p "${cfg.dataDir}"
      '';

      serviceConfig =
        let
          copyConfig = pkgs.writeShellApplication {
            name = "lxmd-copy-config-files";
            text = ''
              install -Dm400 ${cfg.configFile} ${cfg.dataDir}/config
              install -Dm400 ${cfg.identityFile} ${cfg.dataDir}/identity
            '';
          };
        in
        {
          SupplementaryGroups = cfg.extraGroups;
          RuntimeDirectory = baseNameOf cfg.dataDir;
          CacheDirectory = baseNameOf cfg.dataDir;

          ExecStartPre = lib.getExe copyConfig;
          ExecStart =
            "${cfg.package}/bin/lxmd --verbose --config ${cfg.dataDir}"
            + lib.optionalString config.services.rnsd.enable " --rnsconfig ${config.services.rnsd.dataDir}";
        };
    };
  };

  meta.maintainers = with lib.maintainers; [ drupol ];
}
