{
  den.aspects.base = {
    nixos =
      { lib, ... }:
      {
        environment = {
          # Remove rsync and strace
          defaultPackages = lib.mkForce [ ];
        };
      };
  };
}
