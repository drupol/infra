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

    nixos = {
      # imports = [
      #   inputs.infra-private.nixosModules.reticulum-server
      #   ./_rnsd-service.nix
      #   ./_lxmd-service.nix
      # ];

      # nixpkgs = {
      #   overlays = [
      #     (final: _prev: {
      #       master = import inputs.nixpkgs-master {
      #         inherit (final) config;
      #         inherit (final) system;
      #       };
      #     })
      #   ];
      # };

      # TODO: On hold for the moment
      # TODO: Find a way to share the /var/lib/rnsd directory between the rnsd service and the lxmd service
      # services.rnsd = {
      #   enable = false;
      #   package = pkgs.master.rns;
      # };

      # services.lxmd = {
      #   enable = false;
      #   package = pkgs.master.python3Packages.lxmf.override {
      #     propagateRns = true;
      #   };
      # };

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

        systemd.user.services.rnsd = {
          Unit = {
            Description = "Reticulum service";
          };

          Service = {
            Type = "simple";
            ExecStart = "${pkgs.master.rns}/bin/rnsd --verbose";
            Restart = "always";
          };
        };

        systemd.user.services.lxmf = {
          Unit = {
            Description = "Reticulum LXMD service";
          };

          Service = {
            Type = "simple";
            ExecStart = "${lxmf}/bin/lxmd --verbose --rnsconfig /home/pol/.config/reticulum";
            Restart = "always";
          };
        };

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
