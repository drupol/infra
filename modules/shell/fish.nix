{
  den.aspects.shell = {
    homeManager =
      { pkgs, ... }:
      {
        home.shell.enableFishIntegration = true;

        programs = {
          fish = {
            enable = true;

            functions = {
              fish_greeting = "";
            };

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
          };
        };
      };

    nixos =
      { pkgs, ... }:
      {
        programs.fish.enable = true;
        users.defaultUserShell = pkgs.fish;
      };
  };
}
