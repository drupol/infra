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
          with pkgs.master.python3Packages;
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
            ExecStart = "${pkgs.master.rns}/bin/rnsd --service --verbose";
            Restart = "always";
          };
        };

        systemd.user.services.lxmf = {
          Unit = {
            Description = "Reticulum LXMD service";
          };

          Service = {
            Type = "simple";
            ExecStart = "${lxmf}/bin/lxmd --service --verbose";
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
