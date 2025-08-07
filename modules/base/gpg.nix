topLevel: {
  flake.modules = {
    homeManager.base =
      { config, ... }:
      {
        programs = {
          gpg = {
            enable = true;
            settings = {
              default-key = topLevel.config.flake.meta.users.${config.home.username}.key;
            };
          };
          keychain = {
            enable = true;
          };
        };
      };
  };
}
