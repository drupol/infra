{
  lib,
  den,
  ...
}:
{
  den.hosts.x86_64-linux.apollo.users.pol = { };

  den.aspects.apollo = {
    includes = with den.aspects; [
      base
      desktop
      dev
      (facter ./facter.json)
      guacamole
      noise-station-server
      openssh
      shell
      tika
      vpn

      # Users
      root
      pol
    ];

    nixos = {
      boot = {
        # Use the GRUB 2 boot loader.
        loader.grub.enable = true;
        loader.grub.device = "/dev/sdb";
        loader.grub.useOSProber = false;

        # boot.loader.grub.efiSupport = true;
        # boot.loader.grub.efiInstallAsRemovable = true;
        # boot.loader.efi.efiSysMountPoint = "/boot/efi";
        kernel = {
          sysctl = {
            "net.ipv4.conf.all.forwarding" = lib.mkForce true;
            "net.ipv6.conf.all.forwarding" = lib.mkForce true;
          };
        };

        initrd.availableKernelModules = [
          "ehci_pci"
          "ahci"
          "xhci_pci"
          "firewire_ohci"
          "usb_storage"
          "usbhid"
          "sd_mod"
        ];

        kernelModules = [ "kvm-intel" ];
      };

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/6fb8e36f-069c-43db-a843-1e345b17ec04";
        fsType = "ext4";
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/f70058b0-0600-4a7c-a226-37bf10eb307d"; }
      ];
    };
  };
}
