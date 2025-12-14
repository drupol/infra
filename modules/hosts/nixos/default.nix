{
  config,
  ...
}:
{
  flake.modules.nixos."hosts/nixos" =
    { lib, ... }:
    {
      imports =
        with config.flake.modules.nixos;
        [
          # Modules
          ai
          base
          dev
          facter
          openssh
          shell
          vpn

          # Users
          root
          pol
        ]
        # Specific Home-Manager modules
        ++ [
          {
            home-manager.users.pol = {
              imports = with config.flake.modules.homeManager; [
                base
                shell
              ];
            };
          }
        ];

      boot = {
        # Use the GRUB 2 boot loader.
        loader.grub.enable = true;
        # boot.loader.grub.efiSupport = true;
        # boot.loader.grub.efiInstallAsRemovable = true;
        # boot.loader.efi.efiSysMountPoint = "/boot/efi";
        # Define on which hard drive you want to install Grub.
        loader.grub.device = "/dev/sda"; # or "nodev" for efi only
        kernel = {
          sysctl = {
            "net.ipv4.conf.all.forwarding" = lib.mkForce true;
            "net.ipv6.conf.all.forwarding" = lib.mkForce true;
          };
        };

        initrd.availableKernelModules = [
          "xhci_pci"
          "ehci_pci"
          "ahci"
          "usbhid"
          "usb_storage"
          "sd_mod"
          "sr_mod"
        ];

        kernelModules = [ "kvm-intel" ];
      };

      facter.reportPath = ./facter.json;

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/7bb30cda-a7fd-4f83-9cea-a4a80ede8a6e";
        fsType = "ext4";
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/661a3104-2529-42d8-85fa-36249b1fda5d";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/1f4fd44f-280a-452a-9a48-e0b8e402e680";
        fsType = "ext4";
      };

      swapDevices = [ { device = "/dev/disk/by-uuid/87129bb6-05de-4828-8031-2673a2be7ed4"; } ];

      networking = {
        interfaces.eno1.useDHCP = true;
      };
    };
}
