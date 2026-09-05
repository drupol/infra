{
  infra.base = {
    homeManager = {
      home.sessionVariables = {
        EDITOR = "micro";
        VISUAL = "micro";
      };

      programs = {
        micro = {
          enable = true;

          settings = {
            diffgutter = true;
            keymenu = true;
            mkparents = true;
            tabsize = 2;
            tabstospaces = true;
          };
        };
      };
    };
  };
}
