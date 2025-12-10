let
  outputs =
    inputs:
    (import inputs.falake).mkFalake inputs.nixpkgs.lib { inherit inputs; } (
      inputs.import-tree ./modules
    );
in
(import ./unflake.nix) outputs
