{
  den,
  ...
}:
{
  den.aspects.desktop = {
    includes = [
      (den.provides.unfree [ "winbox" ])
    ];

    nixos =
      { pkgs, ... }:
      {
        programs.winbox = {
          enable = true;
          package = pkgs.winbox4;
          openFirewall = true;
        };
      };
  };
}
