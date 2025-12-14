{
  config,
  inputs,
  ...
}:
{
  flake.modules.nixosConfigurations.x1c = {
    imports =
      with config.flake.modules.nixos;
      [
        inputs.disko.nixosModules.disko

        # Modules
        base
        bluetooth
        desktop
        displaylink
        dev
        education
        facter
        fwupd
        games
        shell
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
              pol
              games
              shell
              work
            ];
          };
        }
      ];

    nixpkgs = {
      overlays = [
        (final: _prev: {
          master = import inputs.nixpkgs-master {
            inherit (final) config system;
          };
        })
      ];
    };

    boot = {
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

    facter.reportPath = ./facter.json;

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
}
