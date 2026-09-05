{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    files = {
      url = "github:sini/files";
    };

    flake-compat = {
      flake = false;
      url = "github:NixOS/flake-compat";
    };
  };

  imports = [
    inputs.files.flakeModule
  ];

  # Revisit this when https://github.com/NixOS/flake-compat/pull/91 has landed
  perSystem = {
    files.file."default.nix".text = ''
      (import (
        let
          lock = builtins.fromJSON (builtins.readFile ./flake.lock);
          nodeName = lock.nodes.root.inputs.flake-compat;
        in
        fetchTarball {
          sha256 = lock.nodes.''${nodeName}.locked.narHash;
          url =
            lock.nodes.''${nodeName}.locked.url
              or "https://github.com/NixOS/flake-compat/archive/''${lock.nodes.''${nodeName}.locked.rev}.tar.gz";
        }
      ) { src = ./.; }).defaultNix
    '';
  };
}
