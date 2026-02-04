{
  flake.modules = {
    homeManager.base = {
      programs.fish.enable = true;

      programs.zellij = {
        enable = true;
        attachExistingSession = true;
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
        users.defaultUserShell = pkgs.fish;
        programs.fish.enable = true;

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
