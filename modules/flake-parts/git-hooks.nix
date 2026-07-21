{ inputs, ... }:
{
  flake-file.inputs = {
    git-hooks = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cachix/git-hooks.nix";
    };

    make-shell.url = "github:nicknovitski/make-shell";
  };

  imports = [
    inputs.git-hooks.flakeModule
    inputs.make-shell.flakeModules.default
  ];

  perSystem =
    { config, ... }:
    {
      make-shells.default.shellHook = config.pre-commit.installationScript;
      pre-commit.check.enable = false;
    };
}
