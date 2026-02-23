{
  den.aspects.base = {
    nixos = {
      system.autoUpgrade = {
        enable = false;
        flake = "github:drupol/infra";
        allowReboot = true;
      };
    };
  };
}
