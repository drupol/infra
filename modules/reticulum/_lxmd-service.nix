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

      dataDir = mkOption {
        type = lib.types.path;
        default = "/var/lib/lxmd";
        description = "Path for lxmd state directory.";
      };

      rnsdConfigDir = lib.mkOption {
        type = lib.types.path;
        default = cfg.dataDir;
        description = "Path to rnsd configuration directory.";
      };

      lxmdConfigFile = lib.mkOption {
        type = lib.types.path;
        description = "Path to lxmd configuration file. This file will be copied to the dataDir on service start.";
      };

      identityFile = lib.mkOption {
        type = lib.types.path;
        description = "Path to lxmd identity file. This file will be copied to the dataDir on service start.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.lxmd = {
      enable = true;
      description = "Reticulum Network Lightweight Extensible Message Format Daemon";
      after = [ "network.target" ];
      wants = [ "network-online.target" ];

      environment = {
        HOME = cfg.dataDir;
      };

      serviceConfig =
        let
          copyConfig = pkgs.writeShellApplication {
            name = "lxmd-copy-config-files";
            text = ''
              install -Dm644 ${cfg.lxmdConfigFile} ${cfg.dataDir}/config
              install -Dm644 ${cfg.identityFile} ${cfg.dataDir}/identity
            '';
          };
        in
        {
          WorkingDirectory = cfg.dataDir;
          RuntimeDirectory = "lxmd";
          StateDirectory = "lxmd";
          CacheDirectory = "lxmd";
          DynamicUser = true;

          ExecStartPre = lib.getExe copyConfig;
          ExecStart = "${cfg.package}/bin/lxmd --verbose --config ${cfg.dataDir} --rnsconfig ${cfg.rnsdConfigDir}";
        };
    };
  };

  meta.maintainers = with lib.maintainers; [ drupol qbit ];
}
