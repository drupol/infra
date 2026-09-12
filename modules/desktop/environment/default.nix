{
  den.aspects.desktop = {
    homeManager =
      { pkgs, ... }:
      {
        home = {
          packages = with pkgs; [
            freetube
            kdePackages.akonadi-search
            kdePackages.akregator
            kdePackages.ark
            kdePackages.filelight
            kdePackages.isoimagewriter
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

    nixos =
      { pkgs, ... }:
      {
        networking.firewall =
          let
            winboxPorts = [
              {
                from = 1714;
                to = 1764;
              }
            ];
          in
          {
            allowedTCPPortRanges = winboxPorts;
            allowedUDPPortRanges = winboxPorts;
          };

        programs = {
          kdeconnect.enable = true;
          partition-manager.enable = true;
        };

        programs.kde-pim.enable = false;

        services = {
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

          xserver = {
            enable = true;

            xkb = {
              options = "eurosign:e";
            };
          };
        };

        xdg = {
          portal = {
            config.common.default = "kde";
            enable = true;
            extraPortals = with pkgs; [ kdePackages.xdg-desktop-portal-kde ];
          };
        };
      };
  };
}
