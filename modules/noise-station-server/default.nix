{
  flake.modules.nixos.noise-station-server =
    { pkgs, ... }:
    {
      networking.firewall = {
        allowedTCPPorts = [
          # InfluxDB
          8086
        ];
      };

      services = {
        grafana = {
          enable = true;
          openFirewall = true;
          settings = {
            server.http_addr = "0.0.0.0";
            server.http_port = 3000;
            login_logo = ./Small-Untitled-2025-11-17-2024.svg;
            loading_logo = ./Untitled-2025-11-17-2024.svg;
            menu_logo = ./Small-Untitled-2025-11-17-2024.svg;
          };
          provision = {
            enable = true;
            dashboards.settings = {
              apiVersion = 1;
              providers = [
                {
                  name = "default";
                  options.path = ./dashboards;
                }
              ];
            };
            datasources.settings.datasources = [
              {
                name = "InfluxDB";
                type = "influxdb";
                database = "influxdb";
                editable = false;
                access = "proxy";
                user = "admin";
                password = "noisestation";
                url = "http://127.0.0.1:8086";
                jsonData = {
                  version = "Flux";
                  organization = "default";
                  defaultBucket = "default";
                  tlsSkipVerify = true;
                };
              }
            ];
          };
        };

        influxdb2 = {
          enable = true;

          provision = {
            enable = true;
            initialSetup = {
              bucket = "default";
              organization = "default";
              passwordFile = pkgs.writeText "admin-pw" "noisestation";
              tokenFile = pkgs.writeText "admin-token" "noisestation";
            };
            organizations.default = {
              buckets = {
                default = { };
                usb_temperature = { };
              };
              auths = {
                usb_temperature = {
                  allAccess = true;
                  description = "some noise-station data for Temperature";
                  # readBuckets = [ "default" ];
                  # writeBuckets = [ "default" ];
                };
                default = {
                  allAccess = true;
                  description = "some noise-station data for SPL";
                  # readBuckets = [ "default" ];
                  # writeBuckets = [ "default" ];
                };
              };
            };
          };
        };
      };
    };
}
