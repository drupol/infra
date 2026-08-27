{
  infra.base = {
    homeManager = {
      programs.zellij = {
        enable = true;
        # attachExistingSession = true;
        enableFishIntegration = true;

        settings = {
          copy_on_select = true;
          default_layout = "welcome";
          default_mode = "locked";
          mouse_mode = true;
          pane_frames = true;
          # See https://zellij.dev/documentation/options.html
          show_startup_tips = false;
          simplified_ui = false;
        };
      };
    };

    nixos =
      { pkgs, ... }:
      {
        console = {
          earlySetup = true;
          font = "ter-124b";

          packages = with pkgs; [
            terminus_font
          ];

          useXkbConfig = true;
        };
      };
  };
}
