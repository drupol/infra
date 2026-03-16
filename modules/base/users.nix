{
  flake.modules = {
    nixos.base = {
      services.userborn.enable = true;
    };
  };
}
