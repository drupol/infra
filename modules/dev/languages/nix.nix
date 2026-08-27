{
  infra.dev = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nixpkgs-review
        ];
      };
  };
}
