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

    nixos = { pkgs, ...}: {
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
        ];
      };

      services.rnsd = {
        enable = true;
        package = pkgs.master.rns;
      };

      services.lxmd = {
        enable = true;
        package = pkgs.master.python3Packages.lxmf.override {
          propagateRns = true;
        };
      };

      networking.firewall.allowedTCPPorts = [
        4242
      ];
    };

    homeManager =
      { pkgs, system, ... }:
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
          ];

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
