{
  flake.modules = {
    homeManager.base = {
      programs.fish.enable = true;
    };

    nixos.base =
      { pkgs, ... }:
      {
        programs.fish.enable = true;
        console.useXkbConfig = true;
        users.defaultUserShell = pkgs.fish;
      };
  };
}
