{
  flake.modules = {
    homeManager.games =
      { pkgs, lib, ... }:
      {
        home.packages = with pkgs; [
          master.pkgsi686Linux.etlegacy
        ];

        xdg.desktopEntries.et-fr-beginner-xps = {
          name = "Enemy territory @ France Beginner XPS";
          exec = "${lib.getExe' pkgs.etlegacy "etl"} +connect 46.105.209.160:27960";
          icon = "etl";
          categories = [ "Game" ];
          terminal = false;
        };
      };

    nixos.games = {
      # Only to play enemy territory with Jaymod
      hardware.graphics.enable32Bit = true;
    };
  };

  nixpkgs.allowedUnfreePackages = [
    "etlegacy"
  ];
}
