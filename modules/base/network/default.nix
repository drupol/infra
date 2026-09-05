{
  den,
  ...
}:
{
  infra.base = {
    includes = [
      den.provides.hostname
    ];

    nixos = {
      boot.initrd.systemd.network.wait-online.enable = false;

      networking = {
        dhcpcd.enable = false;
        networkmanager.enable = true;
      };

      services.resolved.enable = true;
      systemd.network.wait-online.enable = false;
    };

    user = {
      extraGroups = [
        "networkmanager"
      ];
    };
  };
}
