{ inputs, lib, ... }:
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
                layout = "us";
              }
              {
                layout = "fr";
              }
              {
                layout = "be";
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

        panels = [
          {
            location = "bottom";
            hiding = "none";
            height = 40;
            floating = false;
            widgets = [
              {
                name = "org.kde.plasma.kicker"; # or "org.kde.plasma.kickoff"
                config = {
                  General = {
                    icon = "nix-snowflake-white";
                  };
                };
              }
              {
                name = "org.kde.plasma.taskmanager";
                config = {
                  General = {
                    fill = false;
                    launchers = [
                      "applications:org.kde.konsole.desktop"
                      "applications:org.kde.dolphin.desktop"
                      "applications:firefox.desktop"
                      "applications:thunderbird.desktop"
                    ];
                  };
                };
              }
              {
                name = "org.kde.plasma.panelspacer";
                config = {
                  expanding = true;
                };
              }
              {
                name = "org.kde.plasma.pager";
                config = {
                  General.displayedText = "Name";
                };
              }
              {
                name = "org.kde.plasma.panelspacer";
                config = {
                  expanding = false;
                };
              }
              {
                systemTray.items = {
                  hidden = [
                    "org.kde.plasma.clipboard"
                    "Yakuake"
                    "KGpg"
                    "Wallet Manager"
                  ];
                  shown = [
                    "org.kde.plasma.bluetooth"
                    "org.kde.plasma.keyboardlayout"
                    "org.kde.plasma.volume"
                    "org.kde.plasma.brightness"
                    "org.kde.plasma.battery"
                    "org.kde.plasma.weather"
                    "org.kde.plasma.networkmanagement"
                    "org.kde.kdeconnect"
                  ];
                };
              }
              {
                name = "org.kde.plasma.digitalclock";
                config = {
                  Appearance = {
                    use24hFormat = true;
                  };
                };
              }
              "org.kde.plasma.showdesktop"
            ];
          }
        ];

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

        powerdevil = {
          general.pausePlayersOnSuspend = true;

          AC = {
            dimKeyboard.enable = true;
            displayBrightness = 50;
            keyboardBrightness = 30;
            inhibitLidActionWhenExternalMonitorConnected = true;
            powerProfile = "performance";
            autoSuspend = {
              idleTimeout = 1800;
            };
            turnOffDisplay = {
              idleTimeout = 600;
            };
          };

          battery = {
            dimKeyboard.enable = true;
            displayBrightness = 10;
            keyboardBrightness = 0;
            powerProfile = "powerSaving";
            dimDisplay = {
              enable = true;
              idleTimeout = 60;
            };
            turnOffDisplay = {
              idleTimeout = 120;
            };
            autoSuspend = {
              action = "sleep";
              idleTimeout = 140;
            };
          };

          batteryLevels = {
            lowLevel = 20;
            criticalLevel = 5;
          };
        };

        configFile = {
          kactivitymanagerd-statsrc =
            let
              appList = [
                "applications:element.desktop"
                "applications:ec-teams.desktop"
                "applications:firefox.desktop"
                "applications:google-protonmail.desktop"
                "applications:umons-webmail.desktop"
                "applications:dev.zed.Zed.desktop"
                "applications:code.desktop"
                "applications:signal.desktop"
                "applications:thunderbird.desktop"
                "applications:et-fr-beginner-xps.desktop"
              ];
            in
            {
              "Favorites-org.kde.plasma.kickoff.favorites.instance-3-global" = {
                ordering = lib.concatStringsSep "," appList;
              };
            };

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
            Dialogs = {
              FirstRun = false;
            };
            Window = {
              DynamicTabTitles = true;
              KeepAbove = false;
              KeepOpen = true;

              ToggleToFocus = false;

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

              move-session-left = "Ctrl+Left";
              move-session-right = "Ctrl+Right";

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
