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
