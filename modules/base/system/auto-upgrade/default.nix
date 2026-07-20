{
  den.aspects.base = {
    nixos = {
      system.autoUpgrade = {
        enable = false;
        allowReboot = true;
        flake = "github:drupol/infra";
      };
    };
  };
}
