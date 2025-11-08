{
  flake.modules = {
    homeManager.base = {
      programs.fish.enable = true;
    };

    nixos.base =
      { pkgs, ... }:
      {
        console.useXkbConfig = true;
        users.defaultUserShell = pkgs.fish;
      };
  };
}
