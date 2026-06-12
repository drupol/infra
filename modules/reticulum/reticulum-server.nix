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

        services.rnsd = {
          enable = true;
          package = pkgs.rns;
          extraGroups = [ "dialout" ];
        };

        services.lxmd = {
          enable = true;
          package = pkgs.python3Packages.lxmf.override {
            propagateRns = true;
          };
        };

        networking.firewall.allowedTCPPorts = [
          4242
        ];
      };

    homeManager =
      { pkgs, ... }:
      let
        lxmf = pkgs.python3Packages.lxmf.override {
          propagateRns = true;
        };
      in
      {
        home.packages =
          with pkgs;
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
            ExecStart = "${pkgs.rns}/bin/rnsh -l -a afcdd5bf95ede3ba04cb4a946da866fb -- /bin/sh";
            Restart = "always";
          };
        };
      };
  };
}
