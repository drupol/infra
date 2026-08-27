{
  infra.base = {
    nixos = {
      services.pcscd.enable = true;
    };
  };
}
