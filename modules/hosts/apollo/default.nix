{
  lib,
  den,
  ...
}:
{
  den.hosts.x86_64-linux.apollo.users.pol = { };
  den.homes.x86_64-linux."pol@apollo" = { };

  den.hosts.x86_64-linux.apollo.users.root = { };
  den.homes.x86_64-linux."root@apollo" = { };

  den.aspects.pol = {
    provides.apollo = {
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
      ];
    };
  };

  den.aspects.root = {
    provides.apollo = {
      includes = with den.aspects; [
        desktop
        dev
        guacamole
        noise-station-server
        openssh
        shell
        tika
        vpn
      ];
    };
  };

  den.aspects.apollo = {
    nixos = {
      boot = {
        # Use the GRUB 2 boot loader.
        loader.grub.enable = true;
        loader.grub.device = "/dev/sda";
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
