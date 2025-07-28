topLevel: {
  flake.modules = {
    homeManager.dev =
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
      };
  };
}
