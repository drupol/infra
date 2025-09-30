{ inputs, ... }:

{
  flake.modules.nixos."hosts/x1c" = {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices = {
      disk.ssd = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLC1T0HFLU-00BLL_S7SDNF0Y868204";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "1000M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings.allowDiscards = true;
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
      lvm_vg = {
        pool = {
          type = "lvm_vg";
          lvs = {
            swap = {
              size = "32G";
              content = {
                type = "swap";
                randomEncryption = true;
              };
            };
            home = {
              size = "75%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
              };
            };
            nix = {
              size = "100%FREE";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
                mountOptions = [
                  "noatime"
                ];
              };
            };

            root = {
              size = "10G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                mountOptions = [
                  "defaults"
                ];
              };
            };
          };
        };
      };
    };
  };
}
