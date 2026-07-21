{ inputs, ... }:
{
  flake-file.inputs = {
    plasma-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/plasma-manager";
    };
  };

  flake.modules = {
    homeManager.desktop = {
      imports = [
        inputs.plasma-manager.homeManagerModules.plasma-manager
      ];

      programs.konsole = {
        defaultProfile = "Zellij";
        enable = true;

        profiles = {
          zellij = {
            command = "/usr/bin/env zellij --layout welcome";

            extraConfig = {
              "Appearance" = {
                "BoldIntense" = "false";
                "WordMode" = true;
                "WordModeAscii" = false;
              };

              "General" = {
                "TerminalCenter" = "true";
                "TerminalMargin" = "2";
              };

              "Scrolling" = {
                "HighlightScrolledLines" = "false";
                "HistoryMode" = "0";
                "ScrollBarPosition" = "2";
              };
            };

            font = {
              name = "Monospace";
              size = 10;
            };

            name = "Zellij";
          };
        };
      };
    };
  };
}
