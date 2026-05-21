{
  lib,
  ...
}:
{
  den.aspects.ai-local = {
    homeManager =
      { pkgs, ... }:
      let
        mcp-server-time = pkgs.mcp-server-time.overrideAttrs {
          meta.mainProgram = "mcp-server-time";
        };
        mcp-server-sequential-thinking = pkgs.mcp-server-sequential-thinking.overrideAttrs {
          meta.mainProgram = "mcp-server-sequential-thinking";
        };
      in
      {
        programs.mcp = {
          enable = true;
          servers = {
            mcp-server-sequential-thinking = {
              command = lib.getExe mcp-server-sequential-thinking;
              enabled = false;
            };
            mcp-server-memory = {
              command = lib.getExe pkgs.mcp-server-memory;
              enabled = false;
            };
            mcp-server-git = {
              command = lib.getExe pkgs.mcp-server-git;
              enabled = false;
            };
            mcp-server-filesystem = {
              command = lib.getExe pkgs.mcp-server-filesystem;
              enabled = false;
            };
            mcp-server-fetch = {
              command = lib.getExe pkgs.mcp-server-fetch;
              args = [
                "--ignore-robots-txt"
              ];
              enabled = false;
            };
            mcp-server-time = {
              command = lib.getExe mcp-server-time;
              enabled = false;
            };
            thunderbird-mcp = {
              command = lib.getExe pkgs.thunderbird-mcp;
              enabled = false;
            };
          };
        };
      };
  };
}
