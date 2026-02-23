{
  den.aspects.guacamole.nixos = {
    services.guacamole-server = {
      enable = true;
      host = "127.0.0.1";
    };

    services.guacamole-client = {
      enable = true;
      userMappingXml = ./user-mapping.xml;
      settings = {
        guacd-port = 4822;
        guacd-hostname = "localhost";
      };
    };

    services.caddy = {
      enable = true;
      virtualHosts."http://".extraConfig = ''
        handle_path /* {
          rewrite * /guacamole{path}
          reverse_proxy 127.0.0.1:8080 {
             flush_interval -1
          }
        }
      '';
    };

    services.xrdp = {
      enable = true;
      defaultWindowManager = "startplasma-x11";
      openFirewall = true;
    };

    networking = {
      firewall = {
        allowedTCPPorts = [
          80
          443
        ];
      };
    };
  };
}
