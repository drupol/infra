topLevel: {
  flake.modules = {
    homeManager.base =
      { config, pkgs, ... }:
      {
        programs = {
          password-store = {
            enable = true;
            package = pkgs.gopass;
            settings = {
              PASSWORD_STORE_DIR = "${config.xdg.configHome}/.password-store";
              PASSWORD_STORE_KEY = (topLevel.config.flake.meta.users.${config.home.username}).key;
            };
          };
        };

        services.git-sync = {
          enable = true;

          repositories = {
            "pass" = {
              uri = "git@github.com:drupol/pass.git";
              path = "${config.xdg.configHome}/.password-store";
              interval = 600;
            };
          };
        };
      };
  };
}
