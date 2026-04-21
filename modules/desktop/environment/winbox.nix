{
  den,
  ...
}:
{
  den.aspects.desktop = {
    includes = [
      (den.provides.unfree [ "winbox" ])
    ];

    nixos = {
      programs.winbox = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
