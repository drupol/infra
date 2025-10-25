{
  unify.modules.openssh.nixos = {
    services = {
      openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          X11Forwarding = true;
          StreamLocalBindUnlink = "yes";
          PasswordAuthentication = false;
        };
      };
    };
  };
}
