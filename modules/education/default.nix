{
  flake.modules.nixos.education =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [ zotero ];
    };
}
