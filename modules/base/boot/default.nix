{
  den.aspects.base = {
    nixos = {
      boot = {
        tmp = {
          cleanOnBoot = true;
          useTmpfs = true;
        };
      };
    };
  };
}
