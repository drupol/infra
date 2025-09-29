{
  flake.modules.nixos.tika = {
    services = {
      tika = {
        enable = true;
        host = "0.0.0.0";
        port = 9998;
        configFile = ./tika-config.xml;
        openFirewall = true;
      };
    };
  };
}
