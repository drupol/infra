{
  infra.fwupd = {
    nixos = {
      services = {
        fwupd = {
          enable = true;
        };
      };
    };
  };
}
