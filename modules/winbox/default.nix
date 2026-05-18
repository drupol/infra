{
  den,
  ...
}:
{
  den.aspects.winbox = {
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
