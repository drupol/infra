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
  cfg = config.services.nomadnet;
  peersettingsFormat =
    let
      python = pkgs.python3.withPackages (ps: [ ps.msgpack ]);
    in
    value:
    pkgs.runCommandLocal "nomadnet-peersettings"
      {
        __structuredAttrs = true;
        nativeBuildInputs = [ python ];
        peerSettingsJson = builtins.toJSON value;
        strictDeps = true;
      }
      ''
        printf "%s" "$peerSettingsJson" | python3 ${./peerSettings.py} > "$out"
      '';
  settingsFormat = pkgs.formats.configobj { };
in
{
  config = lib.mkIf cfg.enable {
    systemd.services.nomadnet = {
      after = lib.optionals config.services.rnsd.enable [ "rnsd.service" ];
      description = "Reticulum Network Nomadnet Service";

      preStart =
        let
          copyConfig = lib.optionalString (cfg.settings != null) ''
            install -Dm400 ${settingsFormat.generate "nomadnet.conf" cfg.settings} "$STATE_DIRECTORY"/nomadnet/config
          '';
          copyIdentity = lib.optionalString (cfg.identityFile != null) ''
            install -Dm400 ${cfg.identityFile} "$STATE_DIRECTORY"/nomadnet/storage/identity
          '';
          copyPeerSettings = ''
            install -Dm400 ${peersettingsFormat cfg.peerSettings} "$STATE_DIRECTORY"/nomadnet/storage/peersettings
          '';
          copyRnsdConfig = lib.optionalString config.services.rnsd.enable ''
            install -Dm400 ${settingsFormat.generate "rnsd.conf" cfg.rnsd.settings} "$STATE_DIRECTORY"/rnsd/config
          '';
          copyRnsdIdentities = lib.concatStringsSep "\n" (
            lib.mapAttrsToList (name: file: ''
              install -Dm400 ${file} "$STATE_DIRECTORY"/rnsd/storage/identities/${name}
            '') cfg.rnsd.identities
          );
          copyRnsdTransportIdentity = lib.optionalString (cfg.rnsd.transportIdentityFile != null) ''
            install -Dm400 ${cfg.rnsd.transportIdentityFile} "$STATE_DIRECTORY"/rnsd/storage/transport_identity
          '';
        in
        copyRnsdConfig
        + copyConfig
        + copyRnsdTransportIdentity
        + copyIdentity
        + copyPeerSettings
        + copyRnsdIdentities;

      serviceConfig = {
        CacheDirectory = "nomadnet";
        DynamicUser = true;

        ExecStart = ''
          ${lib.getExe cfg.package} --daemon --console --config ''${STATE_DIRECTORY}/nomadnet --rnsconfig ''${STATE_DIRECTORY}/rnsd
        '';

        ProtectSystem = "strict";
        RuntimeDirectory = "nomadnet";
        StateDirectory = "nomadnet";
        SupplementaryGroups = cfg.extraGroups;
      };
    };
  };

  options = {
    services.nomadnet = {
      enable = mkEnableOption "Enable nomadnet";

      extraGroups = mkOption {
        default = [ ];
        description = "Additional groups for the nomadnet service user.";
        type = lib.types.listOf lib.types.str;
      };

      identityFile = lib.mkOption {
        default = null;
        description = "Path to nomadnet identity file. This file will be copied to the stateDir on service start.";
        type = lib.types.nullOr lib.types.path;
      };

      package = mkPackageOption pkgs "nomadnet" { };

      peerSettings = {
        announce_interval = lib.mkOption {
          default = 25200; # 7 hours
          description = "Interval in seconds for announcing the node to the propagation node.";
          type = lib.types.int;
        };

        display_name = lib.mkOption {
          default = null;
          description = "Display name of the node. This is used for the display name in the nomadnet console and is also written to the identity file if it doesn't already contain a display name.";
          type = lib.types.nullOr lib.types.str;
        };

        node_connects = lib.mkOption {
          default = 60;
          description = "Number of node identities to connect to on startup.";
          type = lib.types.int;
        };

        propagation_node = lib.mkOption {
          default = null;
          description = "Propagation node written to $STATE_DIRECTORY/nomadnet/storage/peersettings as a MessagePack map.";
          type = lib.types.nullOr lib.types.str;
        };
      };

      rnsd = {
        identities = mkOption {
          default = { };
          description = "Map of identity names to paths of identity files. Each identity file will be copied to $STATE_DIRECTORY/storage/identities/{name}.";
          type = lib.types.attrsOf lib.types.str;
        };

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

      settings = lib.mkOption {
        default = null;
        description = "Structured nomadnet configuration. The generated file is copied to the dataDir on service start. Use `nomadnet --exampleconfig` to get an example config file.";
        type = lib.types.nullOr settingsFormat.type;
      };
    };
  };

  meta.maintainers = with lib.maintainers; [ drupol ];
}
