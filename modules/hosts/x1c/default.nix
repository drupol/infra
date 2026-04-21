{
  inputs,
  den,
  ...
}:
{
  flake-file.inputs = {
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  den.hosts.x86_64-linux.x1c.users.pol = { };

  den.aspects.x1c = {
    provides.to-users = {
      includes = with den.aspects; [
        base
        (facter ./facter.json)
        bluetooth
        desktop
        dev
        education
        fwupd
        games
        email
        lora
        messaging
        news
        shell
        sound
        vpn
        work
      ];
    };

    nixos =
      { pkgs, ... }:
      {
        imports = [
          inputs.disko.nixosModules.disko
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen
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

        hardware = {
          cpu.intel.npu.enable = true;
        };

        # From https://wiki.nixos.org/wiki/Accelerated_Video_Playback
        environment.sessionVariables = {
          LIBVA_DRIVER_NAME = "iHD";
        };
        environment.systemPackages = [ pkgs.libva-utils ];

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
  };
}
