{
  flake.modules.nixos.base =
    { pkgs, lib, ... }:
    {
      boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    };
}
