{
  den,
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
      { pkgs, ... }:
      let
        lxmf = pkgs.python3Packages.lxmf.override {
          propagateRns = true;
        };
      in
      {
        home.packages = with pkgs; [
          lxmf
          nomadnet
          rns
          sideband
        ];
      };
  };
}
