{ inputs, lib, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.git-hooks.flakeModule
  ];

  perSystem =
    { self', pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
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
          formatter = {
            "json-sort-cli" = {
              command = "${lib.getExe pkgs.bash}";
              options = [
                "-euc"
                ''
                  for file in "$@"; do
                    ${lib.getExe pkgs.json-sort-cli} $file --insert-final-newline true --autofix || true
                  done
                ''
                "--" # bash swallows the second argument when using -c
              ];
              includes = [ "*.json" ];
            };
          };
          on-unmatched = "warn";
        };
      };

      pre-commit.settings.hooks.nix-fmt = {
        enable = true;
        entry = lib.getExe self'.formatter;
      };
    };
}
