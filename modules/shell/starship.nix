{
  infra.shell = {
    homeManager = {
      programs = {
        starship = {
          enable = true;
          enableTransience = true;

          settings = {
            git_branch = {
              disabled = true;
            };

            git_commit = {
              disabled = true;
            };

            git_metrics = {
              disabled = true;
            };

            git_state = {
              disabled = true;
            };

            git_status = {
              disabled = true;
            };
          };
        };
      };
    };
  };
}
