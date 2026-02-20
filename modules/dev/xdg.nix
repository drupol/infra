{
  unify.modules.dev.home =
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
