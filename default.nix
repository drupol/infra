(import ./unflake.nix).withInputs (
  inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)
)
