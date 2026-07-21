{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    deploy-rs = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:serokell/deploy-rs";
    };

    make-shell.url = "github:nicknovitski/make-shell";
  };

  imports = [
    inputs.make-shell.flakeModules.default
  ];

  flake =
    { config, lib, ... }:
    {
      deploy.nodes = lib.mapAttrs' (
        hostname: nixosConfiguration:
        let
          inherit (nixosConfiguration.config.nixpkgs.hostPlatform) system;
        in
        {
          name = hostname;

          value = {
            inherit hostname;
            fastConnection = false;

            profiles.system = {
              confirmTimeout = 300;
              path = inputs.deploy-rs.lib.${system}.activate.nixos nixosConfiguration;
              remoteBuild = true;
              sshUser = "root";
            };
          };
        }
      ) config.nixosConfigurations;
    };

  perSystem =
    { pkgs, ... }:
    {
      make-shells.default = {
        packages = [
          pkgs.deploy-rs
        ];
      };
    };
}
