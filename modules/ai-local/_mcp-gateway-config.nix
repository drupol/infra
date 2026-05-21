# Inspired from https://github.com/p3t33/nixos_flake/blob/master/modules/home-manager/services/mcp-gateway.nix
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.mcp-gateway;
  yamlFormat = pkgs.formats.yaml { };
  defaultSettings = {
    server = {
      inherit (cfg) host port;
    };
  };
in
{
  options.services.mcp-gateway = {
    enable = lib.mkEnableOption "MCP Gateway — universal MCP server multiplexer";
    package = lib.mkPackageOption pkgs "mcp-gateway" { };

    host = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1";
      description = "Host";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 39400;
      description = "Port the gateway listens on.";
    };

    enableMcpIntegration = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to integrate the MCP server config from
        {option}`programs.mcp.servers`.
      '';
    };

    enableConfigurationOnly = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to integrate the MCP server config from
        {option}`programs.mcp.servers`.
      '';
    };

    excludeMCPs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "mcp-gateway" ];
      description = ''
        MCP(s) to exclude from {option}`programs.mcp.servers`.

        Useful when MCP-Gateway itself is present in the MCP server list to
        avoid self-referential configuration.
      '';
    };

    environmentFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = ''
        Environment file as defined in {manpage}`systemd.exec(5)` passed to the service.
      '';
    };

    settings = lib.mkOption {
      inherit (yamlFormat) type;
      default = { };
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

      description = ''
        Settings for MCP Gateway.

        Configuration written to
        {file}`$XDG_CONFIG_HOME/mcp-gateway/gateway.yaml`.

        Options are listed on the github: <https://github.com/MikkoParkkola/mcp-gateway/blob/main/gateway.example.yaml>.
      '';
    };
  };

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
      xdg.configFile."mcp-gateway/gateway.yaml" = {
        source = yamlFormat.generate "gateway.yaml" (
          finalSettings // { backends = (finalSettings.backends or { }) // transformedMcpServers; }
        );
      };

      systemd.user.services.mcp-gateway = {
        Unit = {
          Description = "MCP Gateway";
        };

        Service = {
          Type = "simple";
          ExecStart = "${lib.getExe cfg.package} serve --config %h/.config/mcp-gateway/gateway.yaml";
          Restart = "on-failure";
          RestartSec = 5;
        }
        // lib.optionalAttrs (cfg.environmentFile != null) {
          EnvironmentFile = cfg.environmentFile;
        };
      };
    };
}
