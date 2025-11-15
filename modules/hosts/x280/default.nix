{
  config,
  ...
}:
{
  unify.hosts.nixos.x280 = {
    users.pol.modules = config.unify.hosts.nixos.x280.modules;

    modules = with config.unify.modules; [
      # Modules
      base
      bluetooth
      desktop
      facter
      fwupd
      openssh
      sound
      vpn

      # Users
      pol
    ];

    home =
      { lib, ... }:
      {
        programs.plasma = {
          fonts = lib.mkForce { };

          input.keyboard.layouts = lib.mkForce [
            {
              layout = "be";
            }
          ];

          configFile = {
            plasma-localerc = lib.mkForce {
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
          messages = {
            type = "Application";
            name = "Messages";
            genericName = "Messenger";
            comment = "Google Messages Web";
            exec = "firefox --new-window https://messages.google.com/web/conversations";
            icon = ./Google_Messages.svg;
            terminal = false;
            categories = [
              "AudioVideo"
              "Network"
            ];
          };
          crelan = {
            type = "Application";
            name = "Crelan";
            genericName = "Banking";
            comment = "Crelan Online Banking";
            exec = "firefox --new-window https://mycrelan.crelan.be/";
            icon = ./crelan.svg;
            terminal = false;
            categories = [
              "Network"
              "Office"
            ];
          };
          bnpparibas = {
            type = "Application";
            name = "BNP Paribas Fortis";
            genericName = "Banking";
            comment = "BNP Paribas Fortis Online Banking";
            exec = "firefox --new-window https://www.bnpparibasfortis.be/en/generic/logon";
            icon = ./BNP_Paribas.svg;
            terminal = false;
            categories = [
              "Network"
              "Office"
            ];
          };
        };

        programs.firefox.languagePacks = lib.mkForce [ "fr" ];
        programs.firefox.profiles.default.settings."intl.locale.requested" = lib.mkForce "fr,it";
        programs.firefox.profiles.default.settings."intl.accept_languages" = lib.mkForce "fr,it";
        programs.firefox.profiles.default.settings."font.name.monospace.x-western" = lib.mkForce "";
        programs.firefox.profiles.default.settings."font.name.sans-serif.x-western" = lib.mkForce "";
        programs.firefox.profiles.default.settings."font.name.serif.x-western" = lib.mkForce "";

        programs.thunderbird = {
          settings = {
            "intl.locale.requested" = lib.mkForce "fr,it";
            "intl.accept_languages" = lib.mkForce "fr,it";
          };
        };
      };

    nixos =
      { pkgs, lib, ... }:
      {
        boot.loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          efi.efiSysMountPoint = "/boot/efi";
        };

        programs.firefox.policies.SecurityDevices.p11-kit-proxy = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";

        services = {
          xserver = {
            xkb = {
              layout = "be";
            };
          };
          thermald.enable = true;
          avahi.enable = true;
          pcscd.enable = true;
        };

        facter.reportPath = ./facter.json;

        fileSystems = {
          "/" = {
            device = "/dev/disk/by-uuid/89a4586a-eefb-4dd4-bf06-3953902edc1e";
            fsType = "ext4";
          };

          "/boot/efi" = {
            device = "/dev/disk/by-uuid/155B-2355";
            fsType = "vfat";
          };

          "/home" = {
            device = "/dev/disk/by-uuid/ce407b75-260e-47f0-822e-1984866571db";
            fsType = "ext4";
          };

          "/nix" = {
            device = "/dev/disk/by-uuid/c56d5d01-df37-471e-8827-dc193ceb182b";
            fsType = "ext4";
          };
        };

        swapDevices = [ { device = "/dev/disk/by-uuid/005040e5-7773-438e-8ede-f3f63a242d7d"; } ];

        environment.systemPackages = with pkgs; [
          thunderbird
          libreoffice
          eid-mw
          beidconnect
        ];

        system.autoUpgrade = lib.mkForce {
          enable = true;
          flake = "https://github.com/drupol/infra";
          allowReboot = true;
        };

        i18n.defaultLocale = lib.mkForce "fr_BE.UTF-8";

        fonts.packages = lib.mkForce [ ];
      };
  };
}
