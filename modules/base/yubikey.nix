{
  flake.modules = {
    homeManager.base = {
      services.yubikey-agent = {
        enable = true;
      };
    };
  };
}
