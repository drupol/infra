{
  inputs,
  withSystem,
  ...
}:
{
  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
    inputs.flake-file.flakeModules.default
  ];

  flake = {
    overlays.default = _final: prev: {
      local = withSystem prev.stdenv.hostPlatform.system ({ config, ... }: config.packages);
    };
  };

  flake-file.inputs = {
    nix-webapps.url = "github:TLATER/nix-webapps";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-unstable.url = "github:/nixos/nixpkgs/nixpkgs-unstable";
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
  };

  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;

        overlays = [
          (final: _prev: {
            master = import inputs.nixpkgs-master {
              inherit (final) config;
              inherit system;
            };
          })
          (final: _prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit (final) config;
              inherit system;
            };
          })
          inputs.nix-webapps.overlays.lib
        ];
      };

      pkgsDirectory = ../../pkgs/by-name;
    };
}
