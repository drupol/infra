{
  unify.modules.desktop.nixos =
    { pkgs, ... }:
    {
      programs = {
        kdeconnect.enable = true;
        partition-manager.enable = true;
      };

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
      };

      # See https://github.com/NixOS/nixpkgs/issues/414909#issuecomment-3216038215
      system.userActivationScripts = {
        "restart-plasma" = ''
          ${pkgs.xdg-utils}/bin/xdg-desktop-menu forceupdate
        '';
      };
    };

  unify.modules.desktop.home =
    { pkgs, ... }:
    {
      home = {
        packages = with pkgs; [
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
}
