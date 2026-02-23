{
  den.aspects.news = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          feedr
        ];
      };
  };
}
