{
  flake.modules = {
    homeManager.games =
      { pkgs, lib, ... }:
      {
        home.packages = with pkgs; [
          pkgsi686Linux.etlegacy
        ];

        xdg.desktopEntries.et-fr-beginner-xps = {
          name = "Enemy Territory @ France Beginner XPS";
          exec = "${lib.getExe pkgs.etlegacy} +connect 147.135.128.206:27960";
          icon = "etl";
          categories = [ "Game" ];
          terminal = false;
        };

        xdg.desktopEntries.et-fr-jaymod-xps = {
          name = "Enemy Territory @ Jaymod";
          exec = "${lib.getExe pkgs.pkgsi686Linux.etlegacy} +connect 77.202.125.157:27962";
          icon = "etl";
          categories = [ "Game" ];
          terminal = false;
        };

        xdg.desktopEntries.et-fr-chti-clan = {
          name = "Enemy Territory @ Chti Clan";
          exec = "${lib.getExe pkgs.etlegacy} +connect 92.158.15.163:27960";
          icon = "etl";
          categories = [ "Game" ];
          terminal = false;
        };

        nixpkgs = {
          config.allowUnfree = true;
        };
      };

    nixos.games = {
      # Only to play enemy territory with Jaymod
      hardware.graphics.enable32Bit = true;
    };
  };
}
