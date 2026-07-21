{
  den,
  inputs,
  ...
}:
{
  flake-file.inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  den = {
    aspects.x13 = {
      nixos = {
        imports = [
          inputs.nixos-hardware.nixosModules.common-pc-ssd
        ];

        boot = {
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

          loader = {
            efi = {
              canTouchEfiVariables = true;
              efiSysMountPoint = "/boot/efi";
            };

            systemd-boot.enable = true;
          };
        };

        fileSystems = {
          "/" = {
            device = "/dev/disk/by-uuid/204faa11-b822-4a93-a1ce-9aad34208909";
            fsType = "ext4";
          };

          "/boot/efi" = {
            device = "/dev/disk/by-uuid/9C5C-728F";
            fsType = "vfat";
          };

          "/home" = {
            device = "/dev/disk/by-uuid/5ebb905e-0d3e-4e43-ac34-7038c7bbdef7";
            fsType = "ext4";
          };

          "/nix" = {
            device = "/dev/disk/by-uuid/5b4f6c73-28b0-4792-bda6-c407d8a75a78";
            fsType = "ext4";
          };
        };

        programs = {
          noisetorch = {
            enable = true;
          };

          projecteur = {
            enable = true;
          };
        };

        services = {
          avahi.enable = true;
          thermald.enable = true;

          xserver = {
            xkb = {
              layout = "gb";
            };
          };
        };

        swapDevices = [ { device = "/dev/disk/by-uuid/4d6748a8-dddc-40c5-86ed-04bd3c75c9c0"; } ];
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

    hosts.x86_64-linux.x13.users.pol = { };
  };
}
