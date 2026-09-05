{
  infra.dev = {
    homeManager =
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
  };
}
