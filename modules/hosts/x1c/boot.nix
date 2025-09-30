{
  flake.modules.nixos."hosts/x1c" =
    { pkgs, lib, ... }:
    {
      boot = {
        kernelPackages = lib.mkForce pkgs.linuxPackages_6_12;

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "thunderbolt"
            "nvme"
            "usb_storage"
            "sd_mod"
          ];
        };

        kernelModules = [ "kvm-intel" ];
      };
    };
}
