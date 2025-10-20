{
  inputs,
  withSystem,
  ...
}:
{
  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
  ];

  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfreePredicate = _pkg: true;
        };
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

  flake = {
    overlays.default = _final: prev: {
      local = withSystem prev.stdenv.hostPlatform.system ({ config, ... }: config.packages);
    };
  };
}
