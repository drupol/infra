{
  infra,
  inputs,
  ...
}:
{
  flake-file.inputs = {
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  den = {
    aspects.x1c = {
      includes = with infra; [
        base
        (facter ./facter.json)
        bluetooth
        desktop
        dev
        fwupd
        primary
        reticulum
        shell
        sound
        vpn
        wifi
      ];

      nixos =
        { pkgs, ... }:
        {
          imports = [
            inputs.disko.nixosModules.disko
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen
          ];

          boot = {
            binfmt.emulatedSystems = [ "aarch64-linux" ];
            kernelModules = [ "kvm-intel" ];

            kernelParams = [
              "quiet"
              "splash"
            ];

            loader = {
              efi.canTouchEfiVariables = true;
              systemd-boot.enable = true;
            };

            plymouth.enable = true;
          };

          disko.devices = {
            disk.ssd = {
              content = {
                partitions = {
                  ESP = {
                    content = {
                      format = "vfat";
                      mountpoint = "/boot";
                      type = "filesystem";
                    };

                    size = "1000M";
                    type = "EF00";
                  };

                  luks = {
                    content = {
                      content = {
                        type = "lvm_pv";
                        vg = "pool";
                      };

                      name = "crypted";
                      settings.allowDiscards = true;
                      type = "luks";
                    };

                    size = "100%";
                  };
                };

                type = "gpt";
              };

              device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLC1T0HFLU-00BLL_S7SDNF0Y868204";
              type = "disk";
            };

            lvm_vg = {
              pool = {
                lvs = {
                  home = {
                    content = {
                      format = "ext4";
                      mountpoint = "/home";
                      type = "filesystem";
                    };

                    size = "75%";
                  };

                  nix = {
                    content = {
                      format = "ext4";

                      mountOptions = [
                        "noatime"
                      ];

                      mountpoint = "/nix";
                      type = "filesystem";
                    };

                    size = "100%FREE";
                  };

                  root = {
                    content = {
                      format = "ext4";

                      mountOptions = [
                        "defaults"
                      ];

                      mountpoint = "/";
                      type = "filesystem";
                    };

                    size = "10G";
                  };

                  swap = {
                    content = {
                      randomEncryption = true;
                      type = "swap";
                    };

                    size = "32G";
                  };
                };

                type = "lvm_vg";
              };
            };
          };

          environment = {
            # From https://wiki.nixos.org/wiki/Accelerated_Video_Playback
            sessionVariables = {
              LIBVA_DRIVER_NAME = "iHD";
            };

            systemPackages = [ pkgs.libva-utils ];
          };

          hardware = {
            bluetooth.settings = {
              General = {
                ControllerMode = "dual";
                Experimental = true;
              };
            };

            cpu.intel.npu.enable = true;
          };

          # To share ethernet connection
          networking.firewall.allowedUDPPorts = [
            53
            67
          ];

          services = {
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

            thermald.enable = true;

            xserver = {
              xkb = {
                layout = "us";
              };
            };
          };

          # Limit charge to 80% to extend battery longevity when frequently plugged in.
          # Adjust threshold if longer range is needed.
          systemd.tmpfiles.rules = [
            "w /sys/class/power_supply/BAT0/charge_control_end_threshold - - - - 80"
          ];
        };
    };

    hosts.x86_64-linux.x1c.users.pol = { };
  };
}
