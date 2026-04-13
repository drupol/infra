{ inputs, ... }:
{
  flake-file.inputs = {
    make-shell.url = "github:nicknovitski/make-shell";
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [
    inputs.git-hooks.flakeModule
    inputs.make-shell.flakeModules.default
  ];

  perSystem =
    { config, ... }:
    {
      pre-commit.check.enable = false;
      make-shells.default.shellHook = config.pre-commit.installationScript;
    };
}
