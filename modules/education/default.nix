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
  };
}
