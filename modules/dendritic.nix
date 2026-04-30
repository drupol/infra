{
  inputs,
  den,
  lib,
  ...
}:
{
  flake-file.inputs = {
    den.url = "github:denful/den/feat/fx-pipeline";
    flake-file.url = "github:vic/flake-file";
  };

  imports = [
    (inputs.den.flakeModules.dendritic or { })
    (inputs.flake-file.flakeModules.dendritic or { })
  ];

  den.ctx.user.includes = [ den._.mutual-provider ];
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
