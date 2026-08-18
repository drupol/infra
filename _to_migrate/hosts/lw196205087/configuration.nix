{ user, ... }:
{
  home = {
    homeDirectory = "/home/${user}";
    stateVersion = "22.05";
    username = "${user}";
  };

  targets.genericLinux.enable = true;

  xdg = {
    enable = true;
    mime.enable = true;
  };
}
