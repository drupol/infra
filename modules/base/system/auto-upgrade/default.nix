{
  den.aspects.base = {
    nixos = {
      system.autoUpgrade = {
        allowReboot = true;
        enable = false;
        flake = "github:drupol/infra";
      };
    };
  };
}
