{
  flake.modules = {
    homeManager.education =
      {
        pkgs,
        ...
      }:
      {
        home.packages = with pkgs; [ zotero ];
      };

    nixos.education = {
      programs = {
        noisetorch = {
          enable = true;
        };
        projecteur = {
          enable = true;
        };
      };
    };
  };
}
