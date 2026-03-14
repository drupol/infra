{
  den.aspects.dev.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ corkscrew ];
    };
}
