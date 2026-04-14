{
  flake.modules = {
    homeManager.base =
      { pkgs, ... }:
      {
        xdg = {
          enable = true;
          mime.enable = true;
          userDirs = {
            enable = true;
            createDirectories = true;
            setSessionVariables = true;
            templates = null;
            music = null;
            videos = null;
            publicShare = null;
          };
          autostart.enable = true;
          mimeApps.enable = true;
        };

        home = {
          preferXdgDirectories = true;
          # Checks $HOME for unwanted files and directories.
          packages = with pkgs; [ xdg-ninja ];
        };
      };
  };
}
