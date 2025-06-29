{
  flake.modules = {
    nixos.vpn = {
      services.netbird = {
        enable = true;
        ui.enable = true;
      };
    };
  };
}
