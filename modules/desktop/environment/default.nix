{
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.desktop =
      { pkgs, ... }:
      {
        programs.kdeconnect.enable = true;

        xdg = {
          portal = {
            enable = true;
            config.common.default = "kde";
            extraPortals = with pkgs; [ kdePackages.xdg-desktop-portal-kde ];
          };
        };

        networking.firewall = rec {
          allowedTCPPortRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
          allowedUDPPortRanges = allowedTCPPortRanges;
        };

        services = {
          xserver = {
            enable = true;
            xkb = {
              options = "eurosign:e";
            };
          };
          desktopManager = {
            plasma6 = {
              enable = true;
            };
          };
          displayManager = {
            sddm = {
              enable = true;
            };
          };
          fwupd = {
            enable = true;
          };
        };
      };

    homeManager.desktop =
      {
        pkgs,
        lib,
        config,
        ...
      }:
      {
        nixpkgs = {
          config.allowUnfree = true;
          overlays = [
            inputs.self.overlays.default
          ];
        };

        home = {
          activation = {
            # Remove ksycoca cache on activation
            # So that KDE applications can pick up new .desktop files
            # And it doesn't break my favorite applications shortcuts
            nuke-ksycoca = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              rm -fv ${config.xdg.cacheHome}/ksycoca*
            '';
          };

          packages = with pkgs; [
            kdePackages.akonadi-search
            kdePackages.akregator
            kdePackages.ark
            kdePackages.filelight
            kdePackages.kate
            kdePackages.kcalc
            kdePackages.kdialog
            kdePackages.kgpg
            kdePackages.kpipewire
            kdePackages.krdc
            kdePackages.krfb
            kdePackages.ksystemlog
            kdePackages.kweather
            kdePackages.okular
            kdePackages.plasma-browser-integration
            kdePackages.sddm-kcm
            kdePackages.spectacle
            kdePackages.xdg-desktop-portal-kde
            kdePackages.yakuake
            vlc
          ];
        };
      };
  };
}
