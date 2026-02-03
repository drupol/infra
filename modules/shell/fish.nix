{
  flake.modules = {
    homeManager.shell =
      { pkgs, ... }:
      {
        home.shell.enableFishIntegration = true;

        programs = {
          fish = {
            plugins = [
              {
                name = "autopair";
                src = pkgs.fishPlugins.autopair;
              }
            ];
            shellAliases = {
              ".." = "cd ..";
              "..." = "cd ../..";
              cat = "bat";
              grep = "rg";
            };
            functions = {
              fish_greeting = "";
            };
          };
        };
      };
  };
}
