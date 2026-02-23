{
  den.aspects.education = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        home.packages = with pkgs; [ zotero ];
      };

    nixos = {
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
