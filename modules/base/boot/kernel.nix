{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_6_17;
    };
}
