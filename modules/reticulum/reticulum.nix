{
  den,
  inputs,
  ...
}:
{
  infra.reticulum = {
    includes = [
      (den.provides.unfree [
        "lxmf"
        "lxst"
        "rns"
        "sideband"
      ])
    ];

    homeManager =
      { pkgs, system, ... }:
      let
        lxmf = pkgs.python3Packages.lxmf.override {
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

        home.packages = with pkgs.master; [
          lxmf
          nomadnet
          rns
          sideband
        ];
      };
  };
}
