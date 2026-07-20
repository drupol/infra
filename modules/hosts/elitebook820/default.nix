{
  den,
  ...
}:
{
  den = {
    aspects.elitebook820 = {
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
            device = "/dev/disk/by-uuid/0831c17a-27d6-42b8-a61b-f52cfb02f051";
            fsType = "ext4";
          };

          "/boot" = {
            device = "/dev/disk/by-uuid/5185-45FD";
            fsType = "vfat";
          };
        };

        swapDevices = [ { device = "/dev/disk/by-uuid/066ce479-3611-42e7-9117-f1ef77668010"; } ];
      };

      provides.to-users = {
        includes = with den.aspects; [
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

    hosts.x86_64-linux.elitebook820.users.pol = { };
  };
}
