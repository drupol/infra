{
  infra.dev = {
    homeManager = {
      programs.mergiraf = {
        enable = true;
        enableGitIntegration = true;
        enableJujutsuIntegration = true;
      };
    };
  };
}
