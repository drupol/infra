{
  flake.modules = {
    nixos.base =
      { hostConfig, ... }:
      {
        networking = {
          hostName = hostConfig.name;

          dhcpcd.enable = false;

          networkmanager = {
            enable = true;
          };
        };

        systemd = {
          services.NetworkManager-wait-online.enable = false;
          network.wait-online.enable = false;
        };

        services.resolved = {
          enable = true;
        };
      };
  };
}
