{
  flake.modules.homeManager.dev =
    { config, ... }:
    {
      xdg = {
        userDirs = {
          extraConfig = {
            CODE = "${config.home.homeDirectory}/Code";
          };
        };
      };
    };
}
