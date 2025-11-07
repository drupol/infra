{
  config,
  ...
}:
{
  flake.modules.nixos."hosts/x260" = {
    imports =
      with config.flake.modules.nixos;
      [
        # Modules
        base
        bluetooth
        desktop
        dev
        facter
        fwupd
        shell
        sound
        vpn

        # Users
        root
        pol
        benix
      ]
      # Specific Home-Manager modules
      ++ [
        {
          home-manager.users.benix = {
            imports = with config.flake.modules.homeManager; [
              base
              desktop
              dev
              facter
              shell
              benix
            ];
          };

          home-manager.users.pol = {
            imports = with config.flake.modules.homeManager; [
              base
              desktop
              dev
              facter
              shell
              pol
            ];
          };
        }
      ];

    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];

      kernelModules = [ "kvm-intel" ];
    };

    facter.reportPath = ./facter.json;

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/0441f1d3-2c4c-4038-a76b-b3b4beb755f9";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/7104-F69A";
      fsType = "vfat";
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/1c6de7e9-6a0d-47c5-ac8b-47f0ba6eecc2";
      fsType = "ext4";
      neededForBoot = true;
      options = [ "noatime" ];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/2523be1d-4020-4442-b6c6-6983137be565";
      fsType = "ext4";
    };

    swapDevices = [ { device = "/dev/disk/by-uuid/d71fd11a-2609-4c3f-abc2-5ab794180d89"; } ];

    services = {
      xserver = {
        xkb = {
          layout = "be";
        };
      };
      thermald.enable = true;
      avahi.enable = true;
    };
  };
}
