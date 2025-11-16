{
  flake.modules = {
    homeManager.work =
      { pkgs, ... }:
      {
        nixpkgs = {
          config.allowUnfree = true;
        };

        home.packages = with pkgs; [
          aws-workspaces
        ];
      };
  };

}
