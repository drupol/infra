{
  flake.modules = {
    homeManager.news =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.feedr
        ];
      };
  };
}
