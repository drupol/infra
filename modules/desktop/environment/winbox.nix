{
  flake.modules = {
    nixos.desktop =
      { pkgs, ... }:
      {
        programs.winbox = {
          enable = true;
          package = pkgs.winbox4;
          openFirewall = true;
        };
      };
  };

  nixpkgs = {
    allowedUnfreePackages = [
      "winbox"
    ];
  };
}
