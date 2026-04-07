{
  flake.modules = {
    nixos.desktop = {
      programs.winbox = {
        enable = true;
        openFirewall = true;
      };

      nixpkgs = {
        config.allowUnfree = true;
      };
    };
  };
}
