{
  den,
  inputs,
  ...
}:
{
  den.aspects.reticulum-server = {
    includes = [
      (den.provides.unfree [
        "lxmf"
        "rns"
      ])
    ];

    nixos =
      { pkgs, ... }:
      {
        imports = [
          inputs.infra-private.nixosModules.reticulum-server
          ./_rnsd-service.nix
          ./_lxmd-service.nix
        ];

        nixpkgs = {
          overlays = [
            (final: _prev: {
              master = import inputs.nixpkgs-master {
                inherit (final) config;
                inherit (final) system;
              };
            })
            (final: _prev: {
              nixpkgs-unstable = import inputs.nixpkgs-unstable {
                inherit (final) config;
                inherit (final) system;
              };
            })
          ];
        };

        services.rnsd = {
          enable = true;
          package = pkgs.master.rns;
          extraGroups = [ "dialout" ];
        };

        services.lxmd = {
          enable = true;
          package = pkgs.nixpkgs-unstable.rs-lxmf;
        };

        networking.firewall.allowedTCPPorts = [
          4242
        ];
      };

    homeManager =
      { pkgs, system, ... }:
      let
        lxmf = pkgs.master.python3Packages.lxmf.override {
          propagateRns = true;
        };
      in
      {
        nixpkgs = {
          overlays = [
            (final: _prev: {
              master = import inputs.nixpkgs-master {
                inherit (final) config;
                inherit system;
              };
            })
          ];
        };

        home.packages =
          with pkgs.master;
          [
            rns
          ]
          ++ [ lxmf ];

        systemd.user.services.rnsh = {
          Unit = {
            Description = "Reticulum RNSH service";
          };

          Service = {
            Type = "simple";
            ExecStart = "${pkgs.master.rns}/bin/rnsh -l -a afcdd5bf95ede3ba04cb4a946da866fb -- /bin/sh";
            Restart = "always";
          };
        };
      };
  };
}
