{
  flake.modules = {
    nixos.desktop =
      { pkgs, ... }:
      {
        fonts = {
          enableDefaultPackages = true;
          packages = with pkgs; [
            dina-font
            aporetic
            monaspace
            victor-mono
          ];
        };

        fonts.fontconfig = {
          defaultFonts = {
            monospace = [
              "Aporetic Sans Mono"
            ];
            sansSerif = [ "Aporetic Sans Mono" ];
            serif = [ "Aporetic Sans Mono" ];
          };
        };
      };

    homeManager.desktop = {
      fonts = {
        fontconfig = {
          enable = true;
        };
      };
    };
  };
}
