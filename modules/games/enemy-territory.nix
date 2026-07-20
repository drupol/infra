{
  den,
  ...
}:
{
  den.aspects.games = {
    homeManager =
      {
        lib,
        pkgs,
        ...
      }:
      {
        home.packages = [
          pkgs.pkgsi686Linux.etlegacy
        ];

        xdg = {
          desktopEntries = {
            et-fr-beginner-xps = {
              categories = [ "Game" ];
              exec = "${lib.getExe pkgs.etlegacy} +connect 147.135.128.206:27960";
              icon = "etl";
              name = "Enemy Territory @ France Beginner XPS";
              terminal = false;
            };

            et-fr-jaymod-xps = {
              categories = [ "Game" ];
              exec = "${lib.getExe pkgs.pkgsi686Linux.etlegacy} +connect 77.202.125.157:27962";
              icon = "etl";
              name = "Enemy Territory @ Jaymod";
              terminal = false;
            };

            et-red-and-black = {
              categories = [ "Game" ];
              exec = "${lib.getExe pkgs.etlegacy} +connect 51.38.132.168:27960";
              icon = "etl";
              name = "Enemy Territory @ Red & Black";
              terminal = false;
            };
          };
        };
      };

    includes = [
      (den.provides.unfree [
        "etlegacy"
        "etlegacy-assets"
      ])
    ];

    nixos = {
      # Only to play enemy territory with Jaymod
      hardware.graphics.enable32Bit = true;
    };
  };
}
