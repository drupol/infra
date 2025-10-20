topLevel: {
  unify.modules.base.home =
    { config, ... }:
    {
      programs = {
        gpg = {
          enable = true;
          settings = {
            default-key = topLevel.config.flake.meta.users.${config.home.username}.key;
          };
        };
      };

      services = {
        gpg-agent = {
          enable = true;
          enableSshSupport = true;
          sshKeys = topLevel.config.flake.meta.users.${config.home.username}.keygrip;
        };
      };
    };
}
