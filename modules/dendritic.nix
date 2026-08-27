{
  lib,
  inputs,
  ...
}:
{
  flake-file.inputs = {
    flake-file.url = "github:denful/flake-file";
    den.url = "github:denful/den";
    # This `infra-private` is a private repository mostly used to preconfigure
    # some wifi networks.
    # To disable it, remove this line and the corresponding import below.
    # Then run again `nix run .#write-flake` to regenerate the `flake.nix` file.
    infra-private.url = "github:drupol/infra-private";
  };

  imports = [
    (inputs.den.flakeModules.dendritic or { })
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.namespace "infra" [ inputs.infra-private ])
  ];

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
