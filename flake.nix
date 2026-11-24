# DO-NOT-EDIT. This file was auto-generated using github:denful/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs =
    { self, ... }@args:
    let
      inputs = ((import ./.tack) { overrides = args.tackOverrides or { }; }) // {
        inherit self;
      };

    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
