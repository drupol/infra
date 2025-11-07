{
  config,
  lib,
  ...
}:
{
  flake.modules.nixos."hosts/elitebook820" = {
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
              shell
              benix
            ];
          };

          home-manager.users.pol = {
            imports = with config.flake.modules.homeManager; [
              base
              desktop
              dev
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
      device = "/dev/disk/by-uuid/0831c17a-27d6-42b8-a61b-f52cfb02f051";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/5185-45FD";
      fsType = "vfat";
    };

    swapDevices = [ { device = "/dev/disk/by-uuid/066ce479-3611-42e7-9117-f1ef77668010"; } ];
  };
}
