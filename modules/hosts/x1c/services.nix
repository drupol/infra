{
  flake.modules.nixos."hosts/x1c" = {
    services = {
      xserver = {
        xkb = {
          layout = "us";
        };
      };
      thermald.enable = true;
      avahi.enable = true;
      fprintd = {
        enable = true;
      };
    };

  };
}
