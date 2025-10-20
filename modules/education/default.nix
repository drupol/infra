{
  unify.modules.education.nixos =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [ zotero ];
    };
}
