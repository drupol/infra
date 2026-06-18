{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.nomadnet;
  settingsFormat = pkgs.master.formats.configobj { };
  peersettingsFormat =
    let
      python = pkgs.python3.withPackages (ps: [ ps.msgpack ]);
    in
    value:
    pkgs.runCommandLocal "nomadnet-peersettings"
      {
        nativeBuildInputs = [ python ];
        peerSettingsJson = builtins.toJSON value;
        __structuredAttrs = true;
        strictDeps = true;
      }
      ''
        printf "%s" "$peerSettingsJson" | python3 ${./peerSettings.py} > "$out"
      '';

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

        identities = mkOption {
          type = lib.types.attrsOf lib.types.str;
          default = { };
          description = "Map of identity names to paths of identity files. Each identity file will be copied to $STATE_DIRECTORY/storage/identities/{name}.";
        };
      };

      settings = lib.mkOption {
        type = lib.types.nullOr settingsFormat.type;
        default = null;
        description = "Structured nomadnet configuration. The generated file is copied to the dataDir on service start. Use `nomadnet --exampleconfig` to get an example config file.";
      };

      peerSettings = {
        announce_interval = lib.mkOption {
          type = lib.types.int;
          default = 25200; # 7 hours
          description = "Interval in seconds for announcing the node to the propagation node.";
        };

        node_connects = lib.mkOption {
          type = lib.types.int;
          default = 60;
          description = "Number of node identities to connect to on startup.";
        };

        display_name = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Display name of the node. This is used for the display name in the nomadnet console and is also written to the identity file if it doesn't already contain a display name.";
        };

        propagation_node = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Propagation node written to $STATE_DIRECTORY/nomadnet/storage/peersettings as a MessagePack map.";
        };
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

      preStart =
        let
          copyRnsdConfig = lib.optionalString config.services.rnsd.enable ''
            install -Dm400 ${settingsFormat.generate "rnsd.conf" cfg.rnsd.settings} "$STATE_DIRECTORY"/rnsd/config
          '';
          copyConfig = lib.optionalString (cfg.settings != null) ''
            install -Dm400 ${settingsFormat.generate "nomadnet.conf" cfg.settings} "$STATE_DIRECTORY"/nomadnet/config
          '';
          copyRnsdTransportIdentity = lib.optionalString (cfg.rnsd.transportIdentityFile != null) ''
            install -Dm400 ${cfg.rnsd.transportIdentityFile} "$STATE_DIRECTORY"/rnsd/storage/transport_identity
          '';
          copyIdentity = lib.optionalString (cfg.identityFile != null) ''
            install -Dm400 ${cfg.identityFile} "$STATE_DIRECTORY"/nomadnet/storage/identity
          '';
          copyPeerSettings = ''
            install -Dm400 ${peersettingsFormat cfg.peerSettings} "$STATE_DIRECTORY"/nomadnet/storage/peersettings
          '';
          copyRnsdIdentities = lib.concatStringsSep "\n" (
            lib.mapAttrsToList (name: file: ''
              install -Dm400 ${file} "$STATE_DIRECTORY"/rnsd/storage/identities/${name}
            '') cfg.rnsd.identities
          );
        in
        copyRnsdConfig
        + copyConfig
        + copyRnsdTransportIdentity
        + copyIdentity
        + copyPeerSettings
        + copyRnsdIdentities;

      serviceConfig = {
        DynamicUser = true;
        StateDirectory = "nomadnet";
        SupplementaryGroups = cfg.extraGroups;
        RuntimeDirectory = "nomadnet";
        CacheDirectory = "nomadnet";
        ProtectSystem = "strict";

        ExecStart = ''
          ${lib.getExe cfg.package} --daemon --console --config ''${STATE_DIRECTORY}/nomadnet --rnsconfig ''${STATE_DIRECTORY}/rnsd
        '';
      };
    };
  };

  meta.maintainers = with lib.maintainers; [ drupol ];
}
