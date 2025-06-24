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
          # inputs.deploy-rs.overlays.default
          # (self: super: { deploy-rs = { inherit (pkgs) deploy-rs; lib = super.deploy-rs.lib; }; })
        ];
      };
      pkgsDirectory = ../../pkgs/by-name;
    };

  flake = {
    overlays.default =
      _final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        { config, ... }:
        {
          local = config.packages;
        }
      );
  };
}
