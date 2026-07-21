{
  den.aspects.guacamole = {
    nixos = {
      networking = {
        firewall = {
          allowedTCPPorts = [
            80
            443
          ];
        };
      };

      services = {
        caddy = {
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

        guacamole-client = {
          enable = true;

          settings = {
            guacd-hostname = "localhost";
            guacd-port = 4822;
          };

          userMappingXml = ./user-mapping.xml;
        };

        guacamole-server = {
          enable = true;
          host = "127.0.0.1";
        };

        xrdp = {
          defaultWindowManager = "startplasma-x11";
          enable = true;
          openFirewall = true;
        };
      };
    };
  };
}
