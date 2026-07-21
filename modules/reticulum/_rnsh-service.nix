{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkPackageOption
    ;
  cfg = config.services.rnsh;
  settingsFormat = pkgs.formats.configobj { };
in
{
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.group == null || cfg.user != null;
        message = "services.rnsh.group requires services.rnsh.user to also be set.";
      }
      {
        assertion = !cfg.createUser || cfg.user != null;
        message = "services.rnsh.createUser requires services.rnsh.user to be set.";
      }
      {
        assertion = !cfg.createGroup || cfg.user != null;
        message = "services.rnsh.createGroup requires services.rnsh.user to be set.";
      }
    ];

    systemd.services.rnsh = {
      after = lib.optionals config.services.rnsd.enable [ "rnsd.service" ];
      description = "Reticulum Network Shell";
      environment.HOME = "/var/lib/rnsh";

      preStart =
        let
          copyAllowedIdentities = lib.optionalString (cfg.allowed_identities != [ ]) ''
            install -Dm400 /dev/stdin "$STATE_DIRECTORY"/.rnsh/allowed_identities << 'EOF'
            ${lib.concatStringsSep "\n" cfg.allowed_identities}
            EOF
          '';
          copyConfig = lib.optionalString (cfg.rnsd.settings != null) ''
            install -Dm400 ${settingsFormat.generate "rnsd.conf" cfg.rnsd.settings} "$STATE_DIRECTORY"/rnsd/config
          '';
          copyIdentity = lib.optionalString (cfg.identityFile != null) ''
            install -Dm400 ${cfg.identityFile} "$STATE_DIRECTORY"/rnsd/storage/identities/rnsh.default
            ls -la
          '';
          copyTransportIdentity = lib.optionalString (cfg.rnsd.transportIdentityFile != null) ''
            install -Dm400 ${cfg.rnsd.transportIdentityFile} "$STATE_DIRECTORY"/rnsd/storage/transport_identity
          '';
        in
        copyConfig + copyTransportIdentity + copyAllowedIdentities + copyIdentity;

      serviceConfig = {
        CacheDirectory = "rnsh";
        DynamicUser = cfg.user == null;

        ExecStart = ''
          ${lib.getExe' cfg.package "rnsh"} --identity ''${STATE_DIRECTORY}/rnsd/storage/identities/rnsh.default --verbose --listen --config ''${STATE_DIRECTORY}/rnsd
        '';

        ProtectSystem = "strict";
        RuntimeDirectory = "rnsh";
        StateDirectory = "rnsh";
        WorkingDirectory = "/var/lib/rnsh";
      }
      // lib.optionalAttrs (cfg.user != null) {
        User = cfg.user;
      }
      // lib.optionalAttrs (cfg.group != null) {
        Group = cfg.group;
      };
    };

    users = {
      groups = lib.optionalAttrs cfg.createGroup {
        ${if cfg.group != null then cfg.group else cfg.user} = { };
      };

      users = lib.optionalAttrs cfg.createUser {
        ${cfg.user} = {
          group = if cfg.group != null then cfg.group else cfg.user;
          home = "/var/lib/rnsh";
          isSystemUser = true;
        };
      };
    };
  };

  options = {
    services.rnsh = {
      allowed_identities = lib.mkOption {
        default = [ ];
        description = "List of allowed identities allowed to connect to this rnsh instance. These will be written to /var/lib/rnsh/allowed_identities, one hash per line.";
        type = lib.types.listOf lib.types.str;
      };

      command = lib.mkOption {
        default = "/bin/sh";
        description = "Command to run for each incoming connection";
        type = lib.types.str;
      };

      createGroup = mkOption {
        default = false;
        description = "Whether to create the rnsh system group. Uses `services.rnsh.group` when set, otherwise `services.rnsh.user`.";
        type = lib.types.bool;
      };

      createUser = mkOption {
        default = false;
        description = "Whether to create `services.rnsh.user` as a system user.";
        type = lib.types.bool;
      };

      enable = mkEnableOption "Enable rnsh";

      group = mkOption {
        default = null;
        description = "Group under which rnsh runs. This requires `services.rnsh.user` to be set.";
        type = lib.types.nullOr lib.types.str;
      };

      identityFile = lib.mkOption {
        default = null;
        description = "Path to identity file.";
        type = lib.types.nullOr lib.types.str;
      };

      package = mkPackageOption pkgs "rns" { };

      rnsd = {
        settings = lib.mkOption {
          default = null;
          description = "Structured rnsd configuration. The generated file is copied to the dataDir on service start. Use `rnsd --exampleconfig` to get an example config file.";
          type = lib.types.nullOr settingsFormat.type;
        };

        transportIdentityFile = lib.mkOption {
          default = null;
          description = "Path to rnsd identity file. This file will be copied to the dataDir on service start.";
          type = lib.types.nullOr lib.types.str;
        };
      };

      user = mkOption {
        default = null;
        description = "User account under which rnsh runs. When set, DynamicUser is disabled.";
        type = lib.types.nullOr lib.types.str;
      };
    };
  };

  meta.maintainers = with lib.maintainers; [ drupol ];
}
