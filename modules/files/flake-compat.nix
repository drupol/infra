{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    files.url = "github:mightyiam/files";
    flake-compat = {
      url = "github:NixOS/flake-compat";
      flake = false;
    };
  };

  imports = [
    inputs.files.flakeModules.default
  ];

  perSystem =
    { pkgs, config, ... }:
    {
      packages.write-files = config.files.writer.drv;

      files.files = [
        {
          path_ = "default.nix";
          drv = pkgs.writeText "default.nix" ''
            (import (
              let
                lock = builtins.fromJSON (builtins.readFile ./flake.lock);
                nodeName = lock.nodes.root.inputs.flake-compat;
              in
              fetchTarball {
                url =
                  lock.nodes.''${nodeName}.locked.url
                    or "https://github.com/NixOS/flake-compat/archive/''${lock.nodes.''${nodeName}.locked.rev}.tar.gz";
                sha256 = lock.nodes.''${nodeName}.locked.narHash;
              }
            ) { src = ./.; }).defaultNix
          '';
        }
      ];
    };
}
