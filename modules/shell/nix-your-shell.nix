{
  flake.modules = {
    homeManager.shell = {
      programs = {
        nix-your-shell = {
          enable = true;
        };
      };
    };
  };
}
