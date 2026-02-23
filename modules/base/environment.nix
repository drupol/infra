{
  flake.modules = {
    nixos.base =
      { lib, ... }:
      {
        environment = {
          # Remove rsync and strace
          defaultPackages = lib.mkForce [ ];
        };
      };
  };
}
