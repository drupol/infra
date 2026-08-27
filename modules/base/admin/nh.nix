{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    make-shell.url = "github:nicknovitski/make-shell";
  };

  imports = [
    inputs.make-shell.flakeModules.default
  ];

  perSystem =
    { pkgs, ... }:
    {
      make-shells.default.packages = with pkgs; [ nh ];
    };

  infra.base = {
    nixos = {
      programs = {
        nh = {
          clean = {
            enable = true;
            extraArgs = "--keep 2";
          };

          enable = true;
        };
      };
    };
  };
}
