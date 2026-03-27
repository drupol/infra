{
  flake.modules = {
    homeManager.dev =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ corkscrew ];
      };
  };
}
