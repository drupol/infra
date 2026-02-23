{
  den.aspects.base = {
    nixos = {
      services.pcscd.enable = true;
    };

    homeManager = {
      services.yubikey-agent = {
        enable = true;
      };
    };
  };
}
