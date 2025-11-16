{
  flake.modules = {
    homeManager.dev =
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
      };

    nixpkgs = {
      config.allowUnfree = true;
    };
  };
}
