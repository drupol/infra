{ inputs, lib, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.git-hooks.flakeModule
  ];

  perSystem =
    { self', ... }:
    {
      treefmt = {
        projectRootFile = "unflake.nix";
        programs = {
          deadnix.enable = true;
          jsonfmt.enable = true;
          nixfmt.enable = true;
          prettier.enable = true;
          shfmt.enable = true;
          statix.enable = true;
          yamlfmt.enable = true;
        };
        settings = {
          on-unmatched = "warn";
        };
      };

      pre-commit.settings.hooks.nix-fmt = {
        enable = true;
        entry = lib.getExe self'.formatter;
      };
    };
}
