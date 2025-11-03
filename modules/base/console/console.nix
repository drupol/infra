{
  flake.modules = {
    homeManager.base = {
      programs.fish.enable = true;
    };

    nixos.base = {
      console.useXkbConfig = true;
    };
  };
}
