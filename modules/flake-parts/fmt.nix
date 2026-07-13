{ inputs, lib, ... }:
{
  flake-file.inputs = {
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
    pedantix.url = "github:swarsel/pedantix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    json-sort.url = "github:drupol/json-sort";
  };

  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.git-hooks.flakeModule
    inputs.pedantix.flakeModules.default
  ];

  perSystem =
    { self', pkgs, ... }:
    {
      treefmt = {
        imports = [
          inputs.json-sort.treefmtModules.default
        ];
        projectRootFile = "flake.nix";
        programs = {
          deadnix.enable = true;
          jsonfmt.enable = true;
          json-sort.enable = true;
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rs;
          };
          oxfmt.enable = true;
          pedantix = {
            enable = true;
            excludes = [
              "flake.nix"
            ];
            priority = -2;
          };
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
