{
  config,
  ...
}:
{
  flake.modules.homeManager.user =
    { lib, ... }:
    {
      programs.plasma = {
        fonts = lib.mkForce { };

        input.keyboard.layouts = [
          {
            layout = "be";
          }
        ];

        configFile = {
          plasma-localerc = {
            Formats = {
              LANG = "fr_BE.UTF-8";
            };
          };
        };
      };

      xdg.desktopEntries = {
        whatsapp = {
          type = "Application";
          name = "Whatsapp";
          genericName = "Messenger";
          comment = "Whatsapp";
          exec = "firefox --new-window https://web.whatsapp.com";
          icon = ./WhatsApp.svg;
          terminal = false;
          categories = [
            "AudioVideo"
            "Network"
          ];
        };
      };
    };

  flake.modules.nixos."hosts/x280" =
    { pkgs, lib, ... }:
    {
      imports =
        with config.flake.modules.nixos;
        [
          # Modules
          base
          bluetooth
          desktop
          facter
          sound
          vpn

          # Users
          root
          user
        ]
        # Specific Home-Manager modules
        ++ [
          {
            home-manager.users.user.imports = with config.flake.modules.homeManager; [
              base
              desktop
              facter
              user
            ];
          }
        ];

      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        efi.efiSysMountPoint = "/boot/efi";
      };

      services = {
        xserver = {
          xkb = {
            layout = "be";
          };
        };
        thermald.enable = true;
        avahi.enable = true;
      };

      facter.reportPath = ./facter.json;

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/89a4586a-eefb-4dd4-bf06-3953902edc1e";
        fsType = "ext4";
      };

      fileSystems."/boot/efi" = {
        device = "/dev/disk/by-uuid/155B-2355";
        fsType = "vfat";
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/ce407b75-260e-47f0-822e-1984866571db";
        fsType = "ext4";
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/c56d5d01-df37-471e-8827-dc193ceb182b";
        fsType = "ext4";
      };

      swapDevices = [ { device = "/dev/disk/by-uuid/005040e5-7773-438e-8ede-f3f63a242d7d"; } ];

      environment.systemPackages = with pkgs; [
        thunderbird
        libreoffice
      ];

      system.autoUpgrade = lib.mkForce {
        enable = true;
        flake = "https://github.com/drupol/infra";
        allowReboot = true;
      };

      i18n.defaultLocale = lib.mkForce "fr_BE.UTF-8";
    };
}
