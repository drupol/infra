{
  lib,
  inputs,
  ...
}:
{
  flake-file.inputs = {
    flake-file.url = "github:denful/flake-file";
    den.url = "github:denful/den";
    import-tree.url = "github:denful/import-tree";
  };

  imports = [
    inputs.den.flakeModules.dendritic
    inputs.flake-file.flakeModules.dendritic
    inputs.flake-file.flakeModules.auto-follow
  ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
