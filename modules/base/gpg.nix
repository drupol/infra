{ den, ... }:
{
  den.aspects.base = {
    homeManager =
      { config, ... }:
      {
        programs = {
          gpg = {
            enable = true;
            settings = {
              default-key = den.aspects.${config.home.username}.meta.key;
            };
          };
        };

        services = {
          gpg-agent = {
            enable = true;
            enableSshSupport = true;
            sshKeys = den.aspects.${config.home.username}.meta.keygrip;
          };
        };
      };
  };
}
