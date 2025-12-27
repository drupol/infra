{
  inputs,
  withSystem,
  ...
}:
{
  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
  ];

  perSystem = {
    pkgsDirectory = ../../pkgs/by-name;
  };

  nixpkgs = {
    # Fix `nix flake show`
    # or else: error: cannot look up '<nixpkgs>' in pure evaluation mode (use '--impure' to override)
    src = inputs.nixpkgs.outPath;
    conf = {
      overlays = [
        (final: _prev: {
          master = import inputs.nixpkgs-master.outPath {
            inherit (final) config;
            inherit (final.stdenv.hostPlatform) system;
          };
        })
        (final: _prev: {
          unstable = import inputs.nixpkgs-unstable.outPath {
            inherit (final) config;
            inherit (final.stdenv.hostPlatform) system;
          };
        })
        inputs.nix-webapps.overlays.lib
        # inputs.deploy-rs.overlays.default
        # (self: super: { deploy-rs = { inherit (pkgs) deploy-rs; lib = super.deploy-rs.lib; }; })
      ];
    };
  };

  flake = {
    overlays.default = _final: prev: {
      local = withSystem prev.stdenv.hostPlatform.system ({ config, ... }: config.packages);
    };
  };
}
