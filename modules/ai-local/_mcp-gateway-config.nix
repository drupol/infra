# Inspired from https://github.com/p3t33/nixos_flake/blob/master/modules/home-manager/services/mcp-gateway.nix
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.mcp-gateway;
  defaultSettings = {
    server = {
      inherit (cfg) host port;
    };
  };
  yamlFormat = pkgs.formats.yaml { };
in
{
  config =
    let
      finalSettings = lib.attrsets.recursiveUpdate defaultSettings cfg.settings;

      transformedMcpServers = lib.optionalAttrs (cfg.enableMcpIntegration && config.programs.mcp.enable) (
        lib.mapAttrs (
          _name: server:
          lib.optionalAttrs (server ? command) {
            command = "${lib.concatStringsSep " " ([ server.command ] ++ (server.args or [ ]))}";
          }
          // lib.optionalAttrs (server ? url) {
            http_url = server.url;
          }
          // {
            #enabled = server.enabled;
            enabled = true;
          }
          // lib.optionalAttrs (server ? env) {
            inherit (server) env;
          }
          // lib.optionalAttrs (server ? description) {
            inherit (server) description;
          }
        ) (lib.filterAttrs (k: _v: !(lib.elem k cfg.excludeMCPs)) config.programs.mcp.servers)
      );
    in
    lib.mkIf cfg.enable {
      systemd.user.services.mcp-gateway = {
        Service = {
          ExecStart = "${lib.getExe cfg.package} serve --config %h/.config/mcp-gateway/gateway.yaml";
          Restart = "on-failure";
          RestartSec = 5;
          Type = "simple";
        }
        // lib.optionalAttrs (cfg.environmentFile != null) {
          EnvironmentFile = cfg.environmentFile;
        };

        Unit = {
          Description = "MCP Gateway";
        };
      };

      xdg.configFile."mcp-gateway/gateway.yaml" = {
        source = yamlFormat.generate "gateway.yaml" (
          finalSettings // { backends = (finalSettings.backends or { }) // transformedMcpServers; }
        );
      };
    };

  options.services.mcp-gateway = {
    enable = lib.mkEnableOption "MCP Gateway — universal MCP server multiplexer";

    enableConfigurationOnly = lib.mkOption {
      default = false;

      description = ''
        Whether to integrate the MCP server config from
        {option}`programs.mcp.servers`.
      '';

      type = lib.types.bool;
    };

    enableMcpIntegration = lib.mkOption {
      default = false;

      description = ''
        Whether to integrate the MCP server config from
        {option}`programs.mcp.servers`.
      '';

      type = lib.types.bool;
    };

    environmentFile = lib.mkOption {
      default = null;

      description = ''
        Environment file as defined in {manpage}`systemd.exec(5)` passed to the service.
      '';

      type = lib.types.nullOr lib.types.path;
    };

    excludeMCPs = lib.mkOption {
      default = [ "mcp-gateway" ];

      description = ''
        MCP(s) to exclude from {option}`programs.mcp.servers`.

        Useful when MCP-Gateway itself is present in the MCP server list to
        avoid self-referential configuration.
      '';

      type = lib.types.listOf lib.types.str;
    };

    host = lib.mkOption {
      default = "127.0.0.1";
      description = "Host";
      type = lib.types.str;
    };

    package = lib.mkPackageOption pkgs "mcp-gateway" { };

    port = lib.mkOption {
      default = 39400;
      description = "Port the gateway listens on.";
      type = lib.types.port;
    };

    settings = lib.mkOption {
      inherit (yamlFormat) type;
      default = { };

      description = ''
        Settings for MCP Gateway.

        Configuration written to
        {file}`$XDG_CONFIG_HOME/mcp-gateway/gateway.yaml`.

        Options are listed on the github: <https://github.com/MikkoParkkola/mcp-gateway/blob/main/gateway.example.yaml>.
      '';

      example = lib.literalExpression ''
        {
          server = {
            host = "192.168.1.123";
            port = 1234;
          };
          meta_mcp = {
            enabled = true;
            cache_tools = true;
            cache_ttl = "400s";
          };
          backends = {
            example = {
              http_url = "https://example/mcp";
            };
          };
        };
      '';
    };
  };
}
