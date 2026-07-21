{
  den.aspects.tika = {
    nixos = {
      services = {
        tika = {
          configFile = ./tika-config.xml;
          enable = true;
          listenAddress = "0.0.0.0";
          openFirewall = true;
          port = 9998;
        };
      };
    };
  };
}
