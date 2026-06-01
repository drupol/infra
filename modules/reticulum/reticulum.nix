{
  den,
  inputs,
  ...
}:
{
  den.aspects.reticulum = {
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

        home.packages = with pkgs.master.python3Packages; [
          nomadnet
          rns
        ];
      };
  };
}
