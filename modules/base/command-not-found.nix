{
  infra.base = {
    homeManager = {
      programs.command-not-found.enable = false;
    };

    nixos = {
      programs.command-not-found.enable = false;
    };
  };
}
