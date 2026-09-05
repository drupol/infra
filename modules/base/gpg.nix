{ infra, ... }:
{
  infra.base = {
    homeManager =
      { config, ... }:
      {
        programs = {
          gpg = {
            enable = true;

            settings = {
              default-key = infra.${config.home.username}.meta.key;
            };
          };
        };

        services = {
          gpg-agent = {
            enable = true;
            enableSshSupport = true;
            sshKeys = infra.${config.home.username}.meta.keygrip;
          };
        };
      };
  };
}
