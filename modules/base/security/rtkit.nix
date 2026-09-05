{
  infra.base = {
    nixos = {
      security.rtkit.enable = true;
    };
  };
}
