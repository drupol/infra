{
  infra.base = {
    nixos = {
      boot = {
        initrd.systemd.enable = true;

        tmp = {
          cleanOnBoot = true;
          useTmpfs = true;
        };
      };
    };
  };
}
