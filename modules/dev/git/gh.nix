{
  unify.modules.dev.home =
    { pkgs, ... }:
    {
      programs = {
        gh = {
          enable = true;
          extensions = [
            pkgs.gh-copilot
          ];
        };
      };

      nixpkgs = {
        config.allowUnfree = true;
      };
    };
}
