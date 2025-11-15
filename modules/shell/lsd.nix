{
  flake.modules = {
    homeManager.shell = {
      programs = {
        lsd = {
          enable = true;
        };
      };
    };
  };
}
