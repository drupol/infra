{
  den,
  ...
}:
{
  den.aspects.reticulum = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          nomadnet
          rns
          sideband
        ];
      };

    includes = [
      (den.provides.unfree [
        "lxmf"
        "lxst"
        "rns"
        "sideband"
      ])
    ];
  };
}
