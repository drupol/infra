{
  den.aspects.tika = {
    nixos = {
      services = {
        tika = {
          enable = true;
          configFile = ./tika-config.xml;
          listenAddress = "0.0.0.0";
          openFirewall = true;
          port = 9998;
        };
      };
    };
  };
}
