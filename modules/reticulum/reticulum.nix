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
        "lxst"
        "rns"
        "sideband"
      ])
    ];

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

        home.packages = with pkgs; [
          master.nomadnet
          rns
          master.sideband
        ];
      };
  };
}
