{
  config,
  inputs,
  ...
}:
{
  unify.hosts.nixos.x1c = {
    modules = with config.unify.modules; [
      base
      bluetooth
      desktop
      dev
      education
      facter
      fwupd
      games
      email
      lora
      messaging
      shell
      sound
      vpn
      work
      pol
    ];

    users.pol.modules = config.unify.hosts.nixos.x1c.modules;

    tags = [
      "desktop"
    ];

    nixos = {
      imports = [
        inputs.disko.nixosModules.disko
      ];

      boot = {
        binfmt.emulatedSystems = [ "aarch64-linux" ];

        plymouth.enable = true;

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        kernelModules = [ "kvm-intel" ];

        kernelParams = [
          "quiet"
          "splash"
        ];
      };

      programs = {
        noisetorch = {
          enable = true;
        };
        projecteur = {
          enable = true;
        };
      };

      facter.reportPath = ./facter.json;

      services = {
        xserver = {
          xkb = {
            layout = "us";
          };
        };
        thermald.enable = true;
        avahi.enable = true;
        fprintd = {
          enable = true;
        };
        logind = {
          settings.Login = {
            # Only suspend on lid closed when laptop is disconnected
            HandleLidSwitch = "ignore";
            HandleLidSwitchDocked = "ignore";
            HandleLidSwitchExternalPower = "lock";
          };
        };
      };

      # To share ethernet connection
      networking.firewall.allowedUDPPorts = [
        53
        67
      ];

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

    fqdn = "x1c.netbird.cloud";
  };
}
