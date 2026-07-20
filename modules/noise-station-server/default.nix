{
  den.aspects.noise-station-server = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        networking.firewall = {
          allowedTCPPorts = [
            # InfluxDB
            8086
            8081 # Image Renderer
          ];
        };

        services = {
          grafana = {
            enable = true;

            declarativePlugins = [
              pkgs.grafanaPlugins.mesak-imagesave-panel
              pkgs.grafana-image-renderer
            ];

            openFirewall = true;

            provision = {
              enable = true;

              dashboards.settings = {
                apiVersion = 1;

                providers = [
                  {
                    options.path = ./dashboards;
                    name = "default";
                  }
                ];
              };

              datasources.settings.datasources = [
                {
                  access = "proxy";
                  database = "influxdb";
                  editable = false;
                  isDefault = true;

                  jsonData = {
                    defaultBucket = "default";
                    organization = "default";
                    tlsSkipVerify = true;
                    version = "Flux";
                  };

                  name = "InfluxDB";
                  password = "noisestation";
                  secureJsonData.token = "noisestation";
                  type = "influxdb";
                  url = "http://127.0.0.1:8086";
                  user = "admin";
                }
              ];
            };

            settings = {
              auth.disable_login_form = false;

              "auth.anonymous" = {
                enabled = true;
              };

              dashboards.default_home_dashboard_path = "${./dashboards/noise-station.json}";
              dataproxy.timeout = 600;

              feature_toggles = {
                enable = "publicDashboards, panelTimeSettings, timeComparison, timeSeriesTable";
              };

              rendering.renderer_token = builtins.hashString "sha256" "11111111111111111111";

              security = {
                secret_key = "11111111111111111111";
              };

              server = {
                domain = "78d2074a4db5.sn.mynetname.net";
                enable_gzip = true;
                http_addr = "0.0.0.0";
                http_port = 3000;
              };
            };
          };

          grafana-image-renderer = {
            enable = true;
            provisionGrafana = true;

            settings = {
              browser."readiness.timeout" = "0";
              server.addr = "0.0.0.0:8081";
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
                auths = {
                  default = {
                    allAccess = true;
                    description = "some noise-station data for SPL";
                    # readBuckets = [ "default" ];
                    # writeBuckets = [ "default" ];
                  };

                  usb_temperature = {
                    allAccess = true;
                    description = "some noise-station data for Temperature";
                    # readBuckets = [ "default" ];
                    # writeBuckets = [ "default" ];
                  };
                };

                buckets = {
                  default = { };
                  usb_temperature = { };
                };
              };
            };
          };
        };

        systemd = {
          services = {
            grafana.serviceConfig.Environment = [
              "GF_RENDERING_TOKEN=${config.services.grafana.settings.rendering.renderer_token}"
              "GF_RENDERING_RENDERER_TOKEN=${config.services.grafana.settings.rendering.renderer_token}"
            ];

            # Set environment variables for grafana-image-renderer service
            grafana-image-renderer.serviceConfig.Environment =
              lib.mkIf config.services.grafana-image-renderer.enable
                [
                  "AUTH_TOKEN=${config.services.grafana.settings.rendering.renderer_token}"
                  "RENDERING_TOKEN=${config.services.grafana.settings.rendering.renderer_token}"
                ];
          };
        };
      };
  };
}
