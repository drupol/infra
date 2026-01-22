{
  flake.modules = {
    homeManager.dev = {
      programs = {
        gh = {
          enable = true;
        };
      };

      nixpkgs = {
        config.allowUnfree = true;
      };
    };
  };
}
