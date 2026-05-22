{
  lib,
  ...
}:
{
  den.aspects.ai-local = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.influxdb2
        ];

        programs.mcp = {
          enable = true;
          servers = {
            influxdb-mcp-server = {
              description = "InfluxDB MCP server for querying and managing time-series data.";
              command = lib.getExe pkgs.influxdb-mcp-server;
              args = [ ];
              enabled = false;
              env = {
                INFLUXDB_TOKEN = "noisestation";
                INFLUXDB_URL = "http://192.168.2.116:8086";
                INFLUXDB_ORG = "default";
              };
            };
            mcp-server-sequential-thinking = {
              description = "Sequential Thinking MCP server for breaking down problems into structured steps.";
              command = lib.getExe pkgs.mcp-server-sequential-thinking;
              args = [ ];
              enabled = false;
            };
            mcp-server-memory = {
              description = "Memory MCP server for storing and retrieving persistent contextual information.";
              command = lib.getExe pkgs.mcp-server-memory;
              args = [ ];
              enabled = false;
            };
            mcp-server-git = {
              description = "Git MCP server for inspecting repositories and managing version control operations.";
              command = lib.getExe pkgs.mcp-server-git;
              args = [ ];
              enabled = false;
            };
            mcp-server-filesystem = {
              description = "Filesystem MCP server for listing, reading, and modifying files and directories.";
              command = lib.getExe pkgs.mcp-server-filesystem;
              args = [ ];
              enabled = false;
            };
            mcp-server-fetch = {
              description = "Fetch MCP server for retrieving content from web pages and remote resources.";
              command = lib.getExe pkgs.mcp-server-fetch;
              args = [
                "--ignore-robots-txt"
              ];
              enabled = false;
            };
            mcp-server-time = {
              description = "Time MCP server for current time lookups and timezone conversions.";
              command = lib.getExe pkgs.mcp-server-time;
              args = [ ];
              enabled = false;
            };
            thunderbird-mcp = {
              description = "Thunderbird MCP server for automating email, contacts, and calendar workflows.";
              command = lib.getExe pkgs.thunderbird-mcp;
              args = [ ];
              enabled = false;
            };
            mcp-gateway = {
              description = "MCP gateway that exposes multiple MCP servers and tools through a single endpoint.";
              url = "http://127.0.0.1:39400/mcp";
              enabled = false;
            };
          };
        };

        programs.codex.enableMcpIntegration = true;
        programs.opencode.enableMcpIntegration = true;
        programs.vscode.profiles.default.enableMcpIntegration = true;
        programs.zed-editor.enableMcpIntegration = true;
      };
  };
}
