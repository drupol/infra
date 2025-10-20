{
  unify.modules.base = {
    nixos = {
      services.pcscd.enable = true;
    };

    home = {
      services.yubikey-agent = {
        enable = true;
      };
    };
  };
}
