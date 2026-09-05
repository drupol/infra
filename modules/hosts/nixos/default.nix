{
  lib,
  infra,
  ...
}:
{
  den = {
    aspects.nixos = {
      nixos = {
        boot = {
          initrd.availableKernelModules = [
            "xhci_pci"
            "ehci_pci"
            "ahci"
            "usbhid"
            "usb_storage"
            "sd_mod"
            "sr_mod"
          ];

          kernel = {
            sysctl = {
              "net.ipv4.conf.all.forwarding" = lib.mkForce true;
              "net.ipv6.conf.all.forwarding" = lib.mkForce true;
            };
          };

          kernelModules = [ "kvm-intel" ];

          loader = {
            grub = {
              # boot.loader.grub.efiSupport = true;
              # boot.loader.grub.efiInstallAsRemovable = true;
              # boot.loader.efi.efiSysMountPoint = "/boot/efi";
              # Define on which hard drive you want to install Grub.
              device = "/dev/sda"; # or "nodev" for efi only
              # Use the GRUB 2 boot loader.
              enable = true;
            };
          };
        };

        fileSystems = {
          "/" = {
            device = "/dev/disk/by-uuid/7bb30cda-a7fd-4f83-9cea-a4a80ede8a6e";
            fsType = "ext4";
          };

          "/boot" = {
            device = "/dev/disk/by-uuid/1f4fd44f-280a-452a-9a48-e0b8e402e680";
            fsType = "ext4";
          };

          "/home" = {
            device = "/dev/disk/by-uuid/661a3104-2529-42d8-85fa-36249b1fda5d";
            fsType = "ext4";
          };
        };

        networking = {
          interfaces.eno1.useDHCP = true;
        };

        swapDevices = [ { device = "/dev/disk/by-uuid/87129bb6-05de-4828-8031-2673a2be7ed4"; } ];
      };

      provides.to-users = {
        includes = with infra; [
          ai
          base
          dev
          (facter ./facter.json)
          openssh
          shell
          vpn
          # Users
          root
        ];
      };
    };

    hosts.x86_64-linux.nixos.users.pol = { };
  };
}
