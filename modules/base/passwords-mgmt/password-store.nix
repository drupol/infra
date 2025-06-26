{
  flake.modules = {
    homeManager.base =
      { config, ... }:
      {
        programs = {
          password-store = {
            enable = true;
            settings = {
              PASSWORD_STORE_DIR = "${config.xdg.configHome}/.password-store";
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
