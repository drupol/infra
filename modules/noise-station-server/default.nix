{
  flake.modules.nixos.noise-station-server =
    { pkgs, ... }:
    {
      networking.firewall = {
        allowedTCPPorts = [
          # InfluxDB
          8086
          8081 # Image Renderer
        ];
      };

      services = {
        grafana-image-renderer = {
          enable = true;
          provisionGrafana = true;
          settings = {
            server.addr = "0.0.0.0:8081";
            browser."readiness.timeout" = "0";
          };
        };

        grafana = {
          enable = true;
          declarativePlugins = [
            (pkgs.grafana-image-renderer.overrideAttrs (oldAttrs: {
              version = "5.5.0";
              src = oldAttrs.src.overrideAttrs (oldSrcAttrs: {
                version = "5.5.0";
                hash = "sha256-/ZvWE8FVK9EBXo1V0AD/rCc5ZyQFea1WiQrKg1JOwt4=";
              });
              vendorHash = "sha256-kGLvstSkucM0tN5l+Vp78IP9EwDx62kukAiOwYD4Vfs=";
            }))
          ];
          openFirewall = true;
          settings = {
            server = {
              domain = "78d2074a4db5.sn.mynetname.net";
              http_addr = "0.0.0.0";
              http_port = 3000;
              enable_gzip = true;
            };
            feature_toggles = {
              enable = "publicDashboards, panelTimeSettings, timeComparison, timeSeriesTable";
            };
            dataproxy.timeout = 600;
            auth.disable_login_form = true;
            "auth.anonymous" = {
              enabled = true;
            };
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
                isDefault = true;
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
                secureJsonData.token = "noisestation";
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
