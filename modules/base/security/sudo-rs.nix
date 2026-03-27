{
  flake.modules = {
    nixos.base = {
      security = {
        sudo.enable = false;
        sudo-rs = {
          enable = true;
          wheelNeedsPassword = false; # Use 'sudo' without a password
        };
      };
    };
  };
}
