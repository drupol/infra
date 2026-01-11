{
  flake.modules.nixos.noise-station-server =
    { pkgs, ... }:
    {
      services = {
        grafana = {
          enable = true;
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
              buckets.default = { };
              auths.default = {
                allAccess = true;
                description = "some noise-station token";
                # readBuckets = [ "default" ];
                # writeBuckets = [ "default" ];
              };
            };
          };
        };
      };
    };
}
