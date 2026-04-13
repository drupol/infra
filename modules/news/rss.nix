{
  flake.modules = {
    homeManager.news =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          feedr
        ];
      };
  };
}
