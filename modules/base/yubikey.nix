{
  flake.modules = {
    nixos.base = {
      services.pcscd.enable = true;
    };

    homeManager.base = {
      services.yubikey-agent = {
        enable = true;
      };
    };
  };
}
