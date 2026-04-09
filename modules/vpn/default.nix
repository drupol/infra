{
  flake.modules = {
    nixos.vpn =
      { config, ... }:
      {
        services.netbird = {
          enable = true;
          ui.enable = config.services.xserver.enable;
          useRoutingFeatures = "both";
        };
      };
  };
}
