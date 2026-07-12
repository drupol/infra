{
  den,
  ...
}:
{
  den.aspects.games = {
    includes = [
      (den.provides.unfree [
        "etlegacy"
        "etlegacy-assets"
      ])
    ];

    homeManager =
      {
        pkgs,
        lib,
        ...
      }:
      {
        home.packages = [
          pkgs.pkgsi686Linux.etlegacy
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

        xdg.desktopEntries.et-red-and-black = {
          name = "Enemy Territory @ Red & Black";
          exec = "${lib.getExe pkgs.etlegacy} +connect 51.38.132.168:27960";
          icon = "etl";
          categories = [ "Game" ];
          terminal = false;
        };
      };

    nixos = {
      # Only to play enemy territory with Jaymod
      hardware.graphics.enable32Bit = true;
    };
  };
}
