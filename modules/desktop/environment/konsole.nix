{ inputs, ... }:
{
  unify.modules.desktop.home = {
    imports = [
      inputs.plasma-manager.homeManagerModules.plasma-manager
    ];

    programs.konsole = {
      enable = true;
      defaultProfile = "Zellij";

      profiles = {
        zellij = {
          name = "Zellij";
          command = "/usr/bin/env zellij --layout welcome";
          font = {
            name = "Monospace";
            size = 10;
          };
          extraConfig = {
            "General" = {
              "TerminalCenter" = "true";
              "TerminalMargin" = "2";
            };
            "Appearance" = {
              "BoldIntense" = "false";
              "WordMode" = true;
              "WordModeAscii" = false;
            };
            "Scrolling" = {
              "HighlightScrolledLines" = "false";
              "HistoryMode" = "0";
              "ScrollBarPosition" = "2";
            };
          };
        };
      };
    };
  };
}
