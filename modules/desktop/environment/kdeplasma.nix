{ inputs, ... }:
{
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      imports = [
        inputs.plasma-manager.homeManagerModules.plasma-manager
      ];

      programs.plasma = {
        enable = true;

        fonts = {
          fixedWidth = {
            family = "Aporetic Sans Mono";
            pointSize = 10;
          };
          general = {
            family = "Aporetic Sans Mono";
            pointSize = 10;
          };
          menu = {
            family = "Aporetic Sans Mono";
            pointSize = 10;
          };
          small = {
            family = "Aporetic Sans Mono";
            pointSize = 8;
          };
          toolbar = {
            family = "Aporetic Sans Mono";
            pointSize = 10;
          };
          windowTitle = {
            family = "Aporetic Sans Mono";
            pointSize = 10;
          };
        };

        input = {
          keyboard = {
            layouts = [
              {
                layout = "gb";
              }
              {
                layout = "fr";
              }
              {
                layout = "be";
              }
              {
                layout = "us";
              }
            ];
            repeatDelay = 600;
            repeatRate = 25;
          };
        };

        kwin = {
          effects = {
            blur.enable = false;
            cube.enable = false;
            desktopSwitching.animation = "off";
            dimAdminMode.enable = false;
            dimInactive.enable = false;
            fallApart.enable = false;
            fps.enable = false;
            minimization.animation = "off";
            shakeCursor.enable = false;
            slideBack.enable = false;
            snapHelper.enable = false;
            translucency.enable = false;
            windowOpenClose.animation = "off";
            wobblyWindows.enable = false;
          };
        };

        workspace = {
          enableMiddleClickPaste = true;
          clickItemTo = "select";
          colorScheme = "BreezeDark";
          splashScreen.engine = "none";
          splashScreen.theme = "none";
          tooltipDelay = 1;
          wallpaper = ../../../files/home/pol/Pictures/Backgrounds/Starry_Nebula_219.png;
        };

        # kwin
        shortcuts = {
          yakuake = {
            toggle-window-state = "Meta+Space";
          };
        };

        configFile = {
          kdeglobals = {
            "KFileDialog Settings" = {
              "Sort directories first" = true;
              "Show Speedbar" = true;
              "View Style" = "DetailTree";
              "Show Inline Previews" = true;
              "Breadcrumb Navigation" = true;
            };
          };

          klaunchrc = {
            BusyCursorSettings = {
              Bouncing = false;
            };
            FeedbackStyle = {
              BusyCursor = false;
            };
          };

          kscreenlockerrc = {
            Daemon = {
              Timeout = 15;
            };
          };

          kwalletrc = {
            Wallet = {
              Enabled = true;
              "First Use" = false;
              "Close When Idle" = false;
              "Close on Screensaver" = false;
              "Leave Open" = true;
              "Prompt on Open" = false;
            };
            "org.freedesktop.secrets"."apiEnabled" = true;
          };

          kwinrc = {
            Desktops = {
              Number = "1";
            };

            EdgeBarrier = {
              CornerBarrier = "false";
              EdgeBarrier = "0";
            };
          };

          plasma-localerc = {
            Formats = {
              LANG = "en_US.UTF-8";
            };
          };

          plasmarc = {
            PlasmaToolTips = {
              Delay = 1;
            };
            Theme = {
              name = "breeze-dark";
            };
          };

          yakuakerc = {
            Window = {
              KeepAbove = "false";
              KeepOpen = "true";

              ToggleToFocus = "false";

              Height = 90;
              Width = 100;

              ShowTabBar = true;
            };

            Shortcuts = {
              # Creates a new session with 2x2 terminal grid
              new-session-quad = "Ctrl+Shift+Up";

              # Switches between sessions
              next-session = "Ctrl+Shift+Right";
              previous-session = "Ctrl+Shift+Left";

              # Switches between terminal within a session
              next-terminal = "Shift+Right";
              previous-terminal = "Shift+Left";

              # Set them to 'none' because their defaults conflict with above shortcuts
              move-session-left = "none";
              move-session-right = "none";

              toggle-window-state = "Meta+Space";
            };
          };
        };
      };

      xdg.autostart.entries = [
        "${pkgs.kdePackages.yakuake}/share/applications/org.kde.yakuake.desktop"
      ];
    };
}
