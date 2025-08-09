{
  unify.modules.vpn = {
    nixos = {
      services.netbird = {
        enable = true;
        ui.enable = true;
      };
      # Required for the Netbird "exit node" feature to work
      networking.firewall.checkReversePath = "loose";
    };
  };
}
