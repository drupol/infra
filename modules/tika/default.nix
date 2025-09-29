{
  flake.modules.nixos.tika = {
    services = {
      tika = {
        enable = true;
        listenAddress = "0.0.0.0";
        port = 9998;
        configFile = ./tika-config.xml;
        openFirewall = true;
      };
    };
  };
}
