{
  lib,
  ...
}:
{
  infra.ai-local = {
    homeManager =
      { config, pkgs, ... }:
      {
        home.packages = [
          pkgs.influxdb2
        ];

        programs = {
          codex.enableMcpIntegration = true;

          mcp = {
            enable = true;

            servers = {
              influxdb-mcp-server = {
                args = [ ];
                command = lib.getExe pkgs.influxdb-mcp-server;
                description = "InfluxDB MCP server for querying and managing time-series data.";
                enabled = false;

                env = {
                  INFLUXDB_ORG = "default";
                  INFLUXDB_TOKEN = "noisestation";
                  INFLUXDB_URL = "http://192.168.2.116:8086";
                };
              };

              mcp-gateway = {
                description = "MCP gateway that exposes multiple MCP servers and tools through a single endpoint.";
                enabled = false;
                url = "http://127.0.0.1:39400/mcp";
              };

              mcp-server-fetch = {
                args = [
                  "--ignore-robots-txt"
                ];

                command = lib.getExe pkgs.mcp-server-fetch;
                description = "Fetch MCP server for retrieving content from web pages and remote resources.";
                enabled = false;
              };

              mcp-server-filesystem = {
                args = [
                  config.home.homeDirectory
                ];

                command = lib.getExe pkgs.mcp-server-filesystem;
                description = "Filesystem MCP server for listing, reading, and modifying files and directories.";
                enabled = false;
              };

              mcp-server-git = {
                args = [ ];
                command = lib.getExe pkgs.mcp-server-git;
                description = "Git MCP server for inspecting repositories and managing version control operations.";
                enabled = false;
              };

              mcp-server-memory = {
                args = [ ];
                command = lib.getExe pkgs.mcp-server-memory;
                description = "Memory MCP server for storing and retrieving persistent contextual information.";
                enabled = false;

                env = {
                  MEMORY_FILE_PATH = "${config.xdg.configHome}/mcp/memory.jsonl";
                };
              };

              mcp-server-sequential-thinking = {
                args = [ ];
                command = lib.getExe pkgs.mcp-server-sequential-thinking;
                description = "Sequential Thinking MCP server for breaking down problems into structured steps.";
                enabled = false;
              };

              mcp-server-time = {
                args = [ ];
                command = lib.getExe pkgs.mcp-server-time;
                description = "Time MCP server for current time lookups and timezone conversions.";
                enabled = false;
              };

              thunderbird-mcp = {
                args = [ ];
                command = lib.getExe pkgs.thunderbird-mcp;
                description = "Thunderbird MCP server for automating email, contacts, and calendar workflows.";
                enabled = false;
              };
            };
          };

          opencode.enableMcpIntegration = true;
          vscode.profiles.default.enableMcpIntegration = true;
          zed-editor.enableMcpIntegration = true;
        };
      };
  };
}
