{
  flake.modules = {
    homeManager.base = {
      programs.zellij = {
        enable = true;
        attachExistingSession = true;
        enableFishIntegration = true;
        settings = {
          # See https://zellij.dev/documentation/options.html
          show_startup_tips = true;
          default_mode = "locked";

          pane_frames = true;
          simplified_ui = false;
          default_layout = "default";

          mouse_mode = true;
          copy_on_select = true;
        };
      };
    };

    nixos.base =
      { pkgs, ... }:
      {
        console = {
          earlySetup = true;
          font = "ter-124b";
          useXkbConfig = true;
          packages = with pkgs; [
            terminus_font
          ];
        };
      };
  };
}
