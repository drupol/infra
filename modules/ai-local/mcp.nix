{
  lib,
  ...
}:
{
  den.aspects.ai-local = {
    homeManager =
      { pkgs, ... }:
      {
        programs.mcp = {
          enable = true;
          servers = {
            mcp-server-sequential-thinking = {
              type = "local";
              command = [ (lib.getExe pkgs.mcp-mcp-server-sequential-thinking) ];
              enabled = false;
            };
            mcp-server-memory = {
              type = "local";
              command = [ (lib.getExe pkgs.mcp-server-memory) ];
              enabled = false;
            };
            mcp-server-git = {
              type = "local";
              command = [ (lib.getExe pkgs.mcp-server-git) ];
              enabled = false;
            };
            mcp-server-filesystem = {
              type = "local";
              command = [ (lib.getExe pkgs.mcp-server-filesystem) ];
              enabled = false;
            };
            mcp-server-fetch = {
              type = "local";
              command = [
                (lib.getExe pkgs.mcp-server-fetch)
                "--ignore-robots-txt"
              ];
              enabled = false;
            };
            mcp-server-time = {
              type = "local";
              command = [ (lib.getExe pkgs.mcp-server-time) ];
              enabled = false;
            };
          };
        };
      };
  };
}
