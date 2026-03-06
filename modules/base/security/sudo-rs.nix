{
  den.aspects.base = {
    nixos = {
      security = {
        sudo.enable = false;
        sudo-rs = {
          enable = true;
          wheelNeedsPassword = false;
        };
      };
    };

    user = {
      extraGroups = [ "wheel" ];
    };
  };
}
