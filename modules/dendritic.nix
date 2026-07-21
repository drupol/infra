{
  lib,
  inputs,
  ...
}:
{
  flake-file.inputs = {
    flake-file.url = "github:denful/flake-file";
    den.url = "github:denful/den";
  };

  imports = [
    (inputs.den.flakeModules.dendritic or { })
    (inputs.flake-file.flakeModules.dendritic or { })
  ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
