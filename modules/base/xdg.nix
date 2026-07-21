{
  den.aspects.base = {
    homeManager =
      { pkgs, ... }:
      {
        home = {
          # Checks $HOME for unwanted files and directories.
          packages = with pkgs; [ xdg-ninja ];
          preferXdgDirectories = true;
        };

        xdg = {
          autostart.enable = true;
          enable = true;
          mime.enable = true;
          mimeApps.enable = true;

          userDirs = {
            createDirectories = true;
            enable = true;
            music = null;
            publicShare = null;
            setSessionVariables = true;
            templates = null;
            videos = null;
          };
        };
      };
  };
}
