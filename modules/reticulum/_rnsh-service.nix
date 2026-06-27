{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.rnsh;
  settingsFormat = pkgs.formats.configobj { };

  inherit (lib)
    mkEnableOption
    mkOption
    mkPackageOption
    ;
in
{
  options = {
    services.rnsh = {
      enable = mkEnableOption "Enable rnsh";
      package = mkPackageOption pkgs "rns" { };

      user = mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "User account under which rnsh runs. When set, DynamicUser is disabled.";
      };

      createUser = mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to create `services.rnsh.user` as a system user.";
      };

      group = mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Group under which rnsh runs. This requires `services.rnsh.user` to be set.";
      };

      createGroup = mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to create the rnsh system group. Uses `services.rnsh.group` when set, otherwise `services.rnsh.user`.";
      };

      identityFile = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Path to identity file.";
      };

      allowed_identities = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "List of allowed identities allowed to connect to this rnsh instance. These will be written to /var/lib/rnsh/allowed_identities, one hash per line.";
      };

      command = lib.mkOption {
        type = lib.types.str;
        default = "/bin/sh";
        description = "Command to run for each incoming connection";
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
    };
  };

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

    users.groups = lib.optionalAttrs cfg.createGroup {
      ${if cfg.group != null then cfg.group else cfg.user} = { };
    };

    users.users = lib.optionalAttrs cfg.createUser {
      ${cfg.user} = {
        isSystemUser = true;
        group = if cfg.group != null then cfg.group else cfg.user;
        home = "/var/lib/rnsh";
      };
    };

    systemd.services.rnsh = {
      description = "Reticulum Network Shell";
      after = lib.optionals config.services.rnsd.enable [ "rnsd.service" ];
      environment.HOME = "/var/lib/rnsh";

      preStart =
        let
          copyConfig = lib.optionalString (cfg.rnsd.settings != null) ''
            install -Dm400 ${settingsFormat.generate "rnsd.conf" cfg.rnsd.settings} "$STATE_DIRECTORY"/rnsd/config
          '';
          copyTransportIdentity = lib.optionalString (cfg.rnsd.transportIdentityFile != null) ''
            install -Dm400 ${cfg.rnsd.transportIdentityFile} "$STATE_DIRECTORY"/rnsd/storage/transport_identity
          '';
          copyAllowedIdentities = lib.optionalString (cfg.allowed_identities != [ ]) ''
            install -Dm400 /dev/stdin "$STATE_DIRECTORY"/.rnsh/allowed_identities << 'EOF'
            ${lib.concatStringsSep "\n" cfg.allowed_identities}
            EOF
          '';
          copyIdentity = lib.optionalString (cfg.identityFile != null) ''
            install -Dm400 ${cfg.identityFile} "$STATE_DIRECTORY"/rnsd/storage/identities/rnsh.default
            ls -la
          '';
        in
        copyConfig + copyTransportIdentity + copyAllowedIdentities + copyIdentity;

      serviceConfig = {
        WorkingDirectory = "/var/lib/rnsh";
        DynamicUser = cfg.user == null;
        StateDirectory = "rnsh";
        RuntimeDirectory = "rnsh";
        CacheDirectory = "rnsh";
        ProtectSystem = "strict";

        ExecStart = ''
          ${lib.getExe' cfg.package "rnsh"} --identity ''${STATE_DIRECTORY}/rnsd/storage/identities/rnsh.default --verbose --listen --config ''${STATE_DIRECTORY}/rnsd
        '';
      }
      // lib.optionalAttrs (cfg.user != null) {
        User = cfg.user;
      }
      // lib.optionalAttrs (cfg.group != null) {
        Group = cfg.group;
      };
    };
  };

  meta.maintainers = with lib.maintainers; [ drupol ];
}
