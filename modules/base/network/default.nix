{
  flake.modules.nixos.base =
    { hostConfig, ... }:
    {
      networking = {
        hostName = hostConfig.name;

        networkmanager = {
          enable = true;
          wifi.backend = "iwd";
        };
        wireless.iwd = {
          enable = true;
          settings = {
            IPv6.Enabled = true;
            Settings.AutoConnect = true;
          };
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
}
