{
  lib,
  den,
  ...
}:
{
  den = {
    aspects = {
      user = {
        homeManager =
          { pkgs, ... }:
          {
            home.file = builtins.listToAttrs (
              builtins.attrValues (
                builtins.mapAttrs (k: v: {
                  name = "Desktop/${k}.desktop";

                  value = {
                    force = true;
                    recursive = true;

                    source =
                      let
                        desktopFile = pkgs.makeDesktopItem (v // { desktopName = v.name; });
                      in
                      "${desktopFile}/share/applications/${v.name}.desktop";
                  };
                }) (den.aspects.user.meta.desktopEntries or { })
              )
            );

            programs = {
              firefox = {
                languagePacks = lib.mkForce [ "fr" ];

                profiles = {
                  default = {
                    settings = {
                      "font.name.monospace.x-western" = lib.mkForce "";
                      "font.name.sans-serif.x-western" = lib.mkForce "";
                      "font.name.serif.x-western" = lib.mkForce "";
                      "intl.accept_languages" = lib.mkForce "fr,it";
                      "intl.locale.requested" = lib.mkForce "fr,it";
                    };
                  };
                };
              };

              plasma = {
                configFile = {
                  plasma-localerc = lib.mkForce {
                    Formats = {
                      LANG = "fr_BE.UTF-8";
                    };
                  };
                };

                fonts = lib.mkForce { };

                input.keyboard.layouts = lib.mkForce [
                  {
                    layout = "be";
                  }
                ];
              };

              thunderbird = {
                settings = {
                  "intl.accept_languages" = lib.mkForce "fr,it";
                  "intl.locale.requested" = lib.mkForce "fr,it";
                };
              };
            };

            xdg.desktopEntries = den.aspects.user.meta.desktopEntries;

          };

        meta = {
          desktopEntries = {
            bnpparibas = {
              categories = [
                "Network"
                "Office"
              ];

              comment = "BNP Paribas Fortis Online Banking";
              exec = "firefox --new-window https://www.bnpparibasfortis.be/en/generic/logon";
              genericName = "Banking";
              icon = ./files/bnp-paribas-fortis.svg;
              name = "BNP Paribas Fortis";
              terminal = false;
              type = "Application";
            };

            crelan = {
              categories = [
                "Network"
                "Office"
              ];

              comment = "Crelan Online Banking";
              exec = "firefox --new-window https://mycrelan.crelan.be/";
              genericName = "Banking";
              icon = ./files/crelan.svg;
              name = "Crelan";
              terminal = false;
              type = "Application";
            };

            facebook = {
              categories = [
                "Network"
              ];

              comment = "Facebook";
              exec = "firefox --new-window https://www.facebook.com";
              genericName = "Social Network";
              icon = ./files/facebook.svg;
              name = "Facebook";
              terminal = false;
              type = "Application";
            };

            messages = {
              categories = [
                "AudioVideo"
                "Network"
              ];

              comment = "Google Messages Web";
              exec = "firefox --new-window https://messages.google.com/web/conversations";
              genericName = "Messenger";
              icon = ./files/google-messages.svg;
              name = "Messages";
              terminal = false;
              type = "Application";
            };

            whatsapp = {
              categories = [
                "AudioVideo"
                "Network"
              ];

              comment = "Whatsapp";
              exec = "firefox --new-window https://web.whatsapp.com";
              genericName = "Messenger";
              icon = ./files/whatsapp.svg;
              name = "Whatsapp";
              terminal = false;
              type = "Application";
            };

            youtube = {
              categories = [
                "Network"
              ];

              comment = "Youtube";
              exec = "firefox --new-window https://www.youtube.com";
              genericName = "Youtube";
              icon = ./files/youtube.svg;
              name = "Youtube";
              terminal = false;
              type = "Application";
            };
          };
        };
      };

      x280 = {
        nixos =
          { pkgs, ... }:
          {
            boot.loader = {
              efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot/efi";
              };

              systemd-boot.enable = true;
            };

            environment.systemPackages = with pkgs; [
              thunderbird
              libreoffice
              eid-mw
              beidconnect
            ];

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

            fonts.packages = lib.mkForce [ ];
            i18n.defaultLocale = lib.mkForce "fr_BE.UTF-8";
            programs.firefox.policies.SecurityDevices.p11-kit-proxy = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";

            services = {
              avahi.enable = true;
              pcscd.enable = true;
              thermald.enable = true;

              xserver = {
                xkb = {
                  layout = "be";
                };
              };

            };

            swapDevices = [ { device = "/dev/disk/by-uuid/005040e5-7773-438e-8ede-f3f63a242d7d"; } ];

            system.autoUpgrade = lib.mkForce {
              enable = true;
              allowReboot = true;
              flake = "git+https://github.com/drupol/infra";
            };

            # Source: https://wiki.nixos.org/wiki/Web_eID
            systemd.tmpfiles.rules = [
              "L+ /usr/lib/x86_64-linux-gnu/libbeidpkcs11.so.0 - - - - ${pkgs.eid-mw}/lib/pkcs11/beidpkcs11.so"
            ];
          };

        provides.to-users = {
          includes = with den.aspects; [
            base
            bluetooth
            desktop
            (facter ./facter.json)
            fwupd
            openssh
            sound
            vpn
            # Users
            root
            user
          ];
        };
      };
    };

    hosts.x86_64-linux.x280.users.user = { };
  };
}
