{
  unify.modules.desktop.nixos =
    { pkgs, ... }:
    {
      programs.winbox = {
        enable = true;
        package = pkgs.winbox4;
        openFirewall = true;
      };
    };
}
