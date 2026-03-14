{
  den.aspects.base = {
    nixos = {
      programs.command-not-found.enable = false;
    };

    homeManager = {
      programs.command-not-found.enable = false;
    };
  };
}
