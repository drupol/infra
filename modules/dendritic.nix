{
  inputs,
  lib,
  ...
}:
{
  flake-file.inputs = {
    den.url = "github:denful/den";
    flake-file.url = "github:denful/flake-file";
  };

  imports = [
    (inputs.den.flakeModules.dendritic or { })
    (inputs.flake-file.flakeModules.dendritic or { })
  ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
