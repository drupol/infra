topLevel: {
  unify.modules.base.home =
    { pkgs, config, ... }:
    {
      programs = {
        password-store = {
          enable = true;
          package = pkgs.gopass;
          settings = {
            PASSWORD_STORE_DIR = "${config.xdg.configHome}/.password-store";
            PASSWORD_STORE_KEY = topLevel.config.flake.meta.users.${config.home.username}.key;
          };
        };
      };
    };
}
