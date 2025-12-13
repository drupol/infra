{
  inputs,
  withSystem,
  ...
}:
{
  # imports = [
  #   inputs.pkgs-by-name-for-flake-parts.flakeModule
  # ];

  # Fix `nix flake show`
  # or else: error: cannot look up '<nixpkgs>' in pure evaluation mode (use '--impure' to override)
  nixpkgs= inputs.nixpkgs.sourceInfo.outPath;

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
