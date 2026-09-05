{
  infra.ai-local = {
    homeManager = {
      programs.opencode = {
        enable = true;

        settings = {
          autoshare = false;
          autoupdate = false;
        };

        web = {
          enable = false;
        };
      };
    };
  };
}
