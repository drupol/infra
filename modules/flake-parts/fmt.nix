{ inputs, lib, ... }:
{
  flake-file.inputs = {
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
  };

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
          nixfmt = {
            enable = true;
            package = pkgs.master.nixfmt-rs;
          };
          prettier.enable = true;
          shfmt.enable = true;
          statix.enable = true;
          yamlfmt.enable = true;
        };
        settings = {
          on-unmatched = "warn";
          formatter = {
            "json-sort" = {
              command = lib.getExe pkgs.json-sort;
              options = [ "--fix" ];
              includes = [ "*.json" ];
            };
          };
        };
      };

      pre-commit.settings.hooks.nix-fmt = {
        enable = true;
        entry = lib.getExe self'.formatter;
      };
    };
}
