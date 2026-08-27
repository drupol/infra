{
  infra.openssh = {
    nixos = {
      services = {
        openssh = {
          enable = true;
          openFirewall = true;

          settings = {
            PasswordAuthentication = false;
            StreamLocalBindUnlink = "yes";
            X11Forwarding = true;
          };
        };
      };
    };
  };
}
