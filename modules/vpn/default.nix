{
  unify.modules.vpn = {
    nixos = {
      services.netbird = {
        enable = true;
        ui.enable = true;
        useRoutingFeatures = "both";
      };
    };
  };
}
