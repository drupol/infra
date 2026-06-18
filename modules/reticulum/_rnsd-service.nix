{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.rnsd;
  settingsFormat = pkgs.master.formats.configobj { };
in
{
  options = {
    services.rnsd = {
      enable = lib.mkEnableOption "Enable Reticulum Network Stack Daemon (rnsd)";
      package = lib.mkPackageOption pkgs "rns" { };

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

      identities = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        description = "Map of identity names to paths of identity files. Each identity file will be copied to $STATE_DIRECTORY/storage/identities/{name}.";
      };

      extraGroups = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Additional groups for the rnsd service user. E.g., add the `dialout` group to allow rnsd to access serial devices (e.g., `/dev/ttyACM0`).";
      };

      healthCheck = {
        enable = lib.mkEnableOption "wait for rnsd to become healthy after startup";

        intervalSeconds = lib.mkOption {
          type = lib.types.ints.positive;
          default = 2;
          description = "Delay in seconds between each `rnstatus` health check attempt.";
        };

        timeoutSeconds = lib.mkOption {
          type = lib.types.ints.positive;
          default = 120;
          description = "Maximum time in seconds to wait for `rnstatus` to succeed during startup.";
        };
      };

      openMulticastPorts = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether to open the UDP ports (27916, 42671) used for multicast peer discovery when the AutoInterface is enabled.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Stable /dev/rnode symlink for Heltec HT-n5262 RNode (LoRa radio)
    # Without this, the RNode lands on a non-deterministic /dev/ttyACMn that
    # can change across reboots depending on USB enumeration order.
    services.udev.extraRules = ''
      SUBSYSTEM=="tty", ATTRS{idVendor}=="239a", ATTRS{idProduct}=="8071", SYMLINK+="rnode", MODE="0660", GROUP="dialout"
    '';

    systemd.services.rnsd = {
      description = "Reticulum Network Stack Daemon";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      preStart =
        let
          copySettings = lib.optionalString (cfg.settings != null) ''
            install -Dm400 ${settingsFormat.generate "rnsd.conf" cfg.settings} "$STATE_DIRECTORY"/config
          '';
          copyTransportIdentity = lib.optionalString (cfg.transportIdentityFile != null) ''
            install -Dm400 ${cfg.transportIdentityFile} "$STATE_DIRECTORY"/storage/transport_identity
          '';
          copyIdentities = lib.concatStringsSep "\n" (
            lib.mapAttrsToList (name: file: ''
              install -Dm400 ${file} "$STATE_DIRECTORY"/storage/identities/${name}
            '') cfg.identities
          );
        in
        copySettings + copyTransportIdentity + copyIdentities;

      serviceConfig =
        let
          waitForHealthy = pkgs.writeShellApplication {
            name = "rnsd-wait-for-health";
            runtimeInputs = [ cfg.package ];
            text = ''
              deadline=$((SECONDS + ${toString cfg.healthCheck.timeoutSeconds}))

              until rnstatus >/dev/null 2>&1; do
                if [ "$SECONDS" -ge "$deadline" ]; then
                  echo "rnsd did not become healthy before timeout (${toString cfg.healthCheck.timeoutSeconds}s)" >&2
                  exit 1
                fi

                sleep ${toString cfg.healthCheck.intervalSeconds}
              done
            '';
          };
        in
        {
          DynamicUser = true;
          StateDirectory = "rnsd";
          SupplementaryGroups = cfg.extraGroups;
          RuntimeDirectory = "rnsd";
          CacheDirectory = "rnsd";
          ProtectSystem = "strict";

          ExecStart = "${lib.getExe' cfg.package "rnsd"} --verbose --config $STATE_DIRECTORY";
        }
        // lib.optionalAttrs cfg.healthCheck.enable {
          ExecStartPost = lib.getExe waitForHealthy;
          TimeoutStartSec = cfg.healthCheck.timeoutSeconds + 5;
        };
    };

    networking.firewall = {
      extraCommands = lib.optionalString (!config.networking.nftables.enable) ''
        ip46tables -A nixos-fw -p udp -m pkttype --pkt-type multicast -m multiport --dports 27916,42671 -j nixos-fw-accept
      '';

      extraInputRules = lib.optionalString config.networking.nftables.enable ''
        meta l4proto udp pkttype multicast udp dport { 27916, 42671 } accept
      '';
    };
  };

  meta = {
    maintainers = with lib.maintainers; [ drupol ];
  };
}
