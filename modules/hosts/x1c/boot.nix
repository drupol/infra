{
  flake.modules.nixos."hosts/x1c" =
    { pkgs, lib, ... }:
    {
      boot = {
        kernelPackages = lib.mkForce pkgs.linuxPackages_6_12;
        plymouth.enable = true;

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        kernelModules = [ "kvm-intel" ];
      };
    };
}
