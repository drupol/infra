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

      dataDir = mkOption {
        type = lib.types.path;
        default = "/var/lib/rnsd";
        description = "Path for rnsd state directory.";
      };

      configFile = lib.mkOption {
        type = lib.types.path;
        description = "Path to rnsd configuration file. This file will be copied to the dataDir on service start.";
      };

      transportInstanceIdentityFile = lib.mkOption {
        type = lib.types.path;
        description = "Path to rnsd identity file. This file will be copied to the dataDir on service start.";
      };

      extraGroups = mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "dialout" ];
        description = "Additional groups for the rnsd service user.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.rnsd = {
      enable = true;
      description = "Reticulum Network Stack Daemon";
      after = [ "network.target" ];
      wants = [ "network-online.target" ];

      environment = {
        HOME = cfg.dataDir;
      };

      serviceConfig =
        let
          copyConfig = pkgs.writeShellApplication {
            name = "rnsd-copy-config-files";
            text = ''
              install -Dm644 ${cfg.configFile} ${cfg.dataDir}/config
              install -Dm644 ${cfg.transportInstanceIdentityFile} ${cfg.dataDir}/storage/transport_identity
            '';
          };
        in
        {
          SupplementaryGroups = cfg.extraGroups;
          WorkingDirectory = cfg.dataDir;
          RuntimeDirectory = "rnsd";
          StateDirectory = "rnsd";
          CacheDirectory = "rnsd";
          DynamicUser = true;

          ExecStartPre = lib.getExe copyConfig;
          ExecStart = "${cfg.package}/bin/rnsd --verbose --config ${cfg.dataDir}";
        };
    };
  };

  meta.maintainers = with lib.maintainers; [ drupol qbit ];
}
