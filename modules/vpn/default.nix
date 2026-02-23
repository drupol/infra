{
  den.aspects.vpn = {
    nixos =
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
