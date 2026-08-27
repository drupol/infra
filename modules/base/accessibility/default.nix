{
  infra.base = {
    nixos = {
      services = {
        orca.enable = false;
        speechd.enable = false;
      };
    };
  };
}
