{
  inputs,
  den,
  lib,
  ...
}:
let
  stateVersion = "25.11";
in
{
  flake-file.inputs = {
    den.url = "github:vic/den";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-file.url = lib.mkDefault "github:vic/flake-file";
    import-tree.url = "github:vic/import-tree";
  };

  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  den.ctx.user.includes = [ den._.mutual-provider ];
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.default = {
    homeManager = {
      home = {
        inherit stateVersion;
      };
    };

    nixos = {
      system = {
        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://search.nixos.org/options?&show=system.stateVersion&from=0&size=50&sort=relevance&type=packages&query=stateVersion).
        inherit stateVersion;
      };
    };
  };
}
