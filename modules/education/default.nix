{
  den.aspects.education.nixos =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [ zotero ];
    };
}
