{
  inputs,
  ...
}:
{
  imports = [
    inputs.make-shell.flakeModules.default
  ];

  den.aspects.base = {
    nixos = {
      programs = {
        nh = {
          enable = true;

          clean = {
            enable = true;
            extraArgs = "--keep 2";
          };
        };
      };
    };
  };

  flake-file.inputs = {
    make-shell.url = "github:nicknovitski/make-shell";
  };

  perSystem =
    { pkgs, ... }:
    {
      make-shells.default.packages = with pkgs; [ nh ];
    };
}
