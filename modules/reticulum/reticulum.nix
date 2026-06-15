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
      {
        home.packages = with pkgs; [
          nomadnet
          rns
          sideband
        ];
      };
  };
}
