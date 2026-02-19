{
  config,
  inputs,
  ...
}:
{
  flake.modules.nixos."hosts/x13" = {
    imports =
      with config.flake.modules.nixos;
      [
        inputs.nixos-hardware.nixosModules.common-pc-ssd
      ]
      ++ [
        # Modules
        base
        bluetooth
        desktop
        dev
        facter
        fwupd
        games
        sound
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
              desktop
              dev
              email
              messaging
              games
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
        efi.efiSysMountPoint = "/boot/efi";
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

    facter.reportPath = ./facter.json;

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/204faa11-b822-4a93-a1ce-9aad34208909";
      fsType = "ext4";
    };

    fileSystems."/boot/efi" = {
      device = "/dev/disk/by-uuid/9C5C-728F";
      fsType = "vfat";
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/5ebb905e-0d3e-4e43-ac34-7038c7bbdef7";
      fsType = "ext4";
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/5b4f6c73-28b0-4792-bda6-c407d8a75a78";
      fsType = "ext4";
    };

    swapDevices = [ { device = "/dev/disk/by-uuid/4d6748a8-dddc-40c5-86ed-04bd3c75c9c0"; } ];

    programs = {
      noisetorch = {
        enable = true;
      };
      projecteur = {
        enable = true;
      };
    };

    services = {
      xserver = {
        xkb = {
          layout = "gb";
        };
      };
      thermald.enable = true;
      avahi.enable = true;
    };
  };
}
