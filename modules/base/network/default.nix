{
  den,
  ...
}:
{
  den.aspects.base = {
    includes = [
      den.provides.hostname
    ];

    nixos = {
      networking = {
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

    user = {
      extraGroups = [
        "networkmanager"
      ];
    };
  };
}
