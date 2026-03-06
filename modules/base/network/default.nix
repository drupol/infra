{
  den.aspects.base = {
    nixos = {
      networking = {
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
