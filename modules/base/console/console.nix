{
  flake.modules = {
    homeManager.base = {
      programs.fish.enable = true;

      programs.zellij = {
        enable = true;
        attachExistingSession = true;
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
