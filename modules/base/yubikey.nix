{
  flake.modules = {
    nixos.base = {
      services.pcscd.enable = true;
    };
  };
}
