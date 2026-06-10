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

      user = mkOption {
        type =
          with lib.types;
          oneOf [
            str
            int
          ];
        default = "rnsd";
        description = "The user rnsd will run as.";
      };

      group = mkOption {
        type =
          with lib.types;
          oneOf [
            str
            int
          ];
        default = "reticulum";
        description = "The group rnsd will run with.";
      };

      dataDir = mkOption {
        type = lib.types.path;
        default = "/var/lib/reticulum/rnsd";
        description = "Path for rnsd state directory.";
      };

      configFile = lib.mkOption {
        type = lib.types.path;
        description = "Path to rnsd configuration file. This file will be copied to the dataDir on service start. Use `rnsd --exampleconfig` to get an example config file.";
      };

      transportIdentityFile = lib.mkOption {
        type = lib.types.str;
        description = "Path to rnsd identity file. This file will be copied to the dataDir on service start.";
      };

      extraGroups = mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Additional groups for the rnsd service user. E.g., add the `dialout` group to allow rnsd to access serial devices (e.g., `/dev/ttyACM0`).";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users.groups.${cfg.group} = { };
    users.users.${cfg.user} = {
      inherit (cfg) group;
      description = "rnsd user";
      isSystemUser = true;
      home = cfg.dataDir;
      createHome = true;
    };

    systemd.services.rnsd = {
      enable = true;
      description = "Reticulum Network Stack Daemon";
      after = [ "network.target" ];
      wants = [ "network-online.target" ];

      environment = {
        HOME = cfg.dataDir;
      };

      preStart = ''
        mkdir -p "${cfg.dataDir}"
      '';

      serviceConfig =
        let
          copyConfig = pkgs.writeShellApplication {
            name = "rnsd-copy-config-files";
            text = ''
              install -Dm400 ${cfg.configFile} ${cfg.dataDir}/config
              install -Dm400 ${cfg.transportIdentityFile} ${cfg.dataDir}/storage/transport_identity
            '';
          };
        in
        {
          SupplementaryGroups = cfg.extraGroups;
          RuntimeDirectory = baseNameOf cfg.dataDir;
          CacheDirectory = baseNameOf cfg.dataDir;

          ExecStartPre = lib.getExe copyConfig;
          ExecStart = "${cfg.package}/bin/rnsd --verbose --config ${cfg.dataDir}";
        };
    };
  };

  meta.maintainers = with lib.maintainers; [ drupol ];
}
