{
  infra.shell = {
    homeManager = {
      programs = {
        direnv = {
          config = {
            global = {
              hide_env_diff = true;
            };
          };

          enable = true;
          nix-direnv.enable = true;
        };
      };
    };
  };
}
