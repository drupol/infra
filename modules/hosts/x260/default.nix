{
  infra,
  ...
}:
{
  den = {
    aspects.x260 = {
      nixos = {
        boot = {
          initrd.availableKernelModules = [
            "xhci_pci"
            "ahci"
            "usb_storage"
            "sd_mod"
            "rtsx_pci_sdmmc"
          ];

          kernelModules = [ "kvm-intel" ];

          loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
          };
        };

        fileSystems = {
          "/" = {
            device = "/dev/disk/by-uuid/0441f1d3-2c4c-4038-a76b-b3b4beb755f9";
            fsType = "ext4";
          };

          "/boot" = {
            device = "/dev/disk/by-uuid/7104-F69A";
            fsType = "vfat";
          };

          "/home" = {
            device = "/dev/disk/by-uuid/2523be1d-4020-4442-b6c6-6983137be565";
            fsType = "ext4";
          };

          "/nix" = {
            device = "/dev/disk/by-uuid/1c6de7e9-6a0d-47c5-ac8b-47f0ba6eecc2";
            fsType = "ext4";
            neededForBoot = true;
            options = [ "noatime" ];
          };
        };

        services = {
          avahi.enable = true;
          thermald.enable = true;

          xserver = {
            xkb = {
              layout = "be";
            };
          };
        };

        swapDevices = [ { device = "/dev/disk/by-uuid/d71fd11a-2609-4c3f-abc2-5ab794180d89"; } ];
      };

      provides.to-users = {
        includes = with infra; [
          base
          bluetooth
          desktop
          dev
          (facter ./facter.json)
          fwupd
          sound
          vpn

          # Users
          root
        ];
      };
    };

    hosts.x86_64-linux.x260.users.pol = { };
  };
}
