{
  unify.modules.base = {
    home = {
      programs.fish.enable = true;
    };

    nixos =
      { pkgs, ... }:
      {
        programs.fish.enable = true;
        console.useXkbConfig = true;
        users.defaultUserShell = pkgs.fish;
      };
  };
}
