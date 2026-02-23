{
  flake.modules = {
    homeManager.dev = {
      programs = {
        gh = {
          enable = true;
        };
      };
    };
  };
}
