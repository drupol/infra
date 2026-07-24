{ inputs, ... }:
{
  flake-file.inputs = {
    plasma-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/plasma-manager";
    };
  };

  den.aspects.desktop = {
    homeManager =
      { pkgs, ... }:
      {
        imports = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
        ];

        programs.plasma = {
          configFile = {
            # Not working yet
            # See: https://github.com/nix-community/plasma-manager/issues/539
            # kactivitymanagerd-statsrc =
            #   let
            #     appList = [
            #       "applications:element.desktop"
            #       "applications:ec-teams.desktop"
            #       "applications:firefox.desktop"
            #       "applications:google-protonmail.desktop"
            #       "applications:dev.zed.Zed.desktop"
            #       "applications:code.desktop"
            #       "applications:signal.desktop"
            #       "applications:thunderbird.desktop"
            #       "applications:et-fr-beginner-xps.desktop"
            #     ];
            #   in
            #   {
            #     "Favorites-org.kde.plasma.kickoff.favorites.instance-3-global" = {
            #       ordering = lib.concatStringsSep "," appList;
            #     };
            #   };

            kdeglobals = {
              "KFileDialog Settings" = {
                "Breadcrumb Navigation" = true;
                "Show Inline Previews" = true;
                "Show Speedbar" = true;
                "Sort directories first" = true;
                "View Style" = "DetailTree";
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
                "Close When Idle" = false;
                "Close on Screensaver" = false;
                Enabled = true;
                "First Use" = false;
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

              Shortcuts = {
                move-session-left = "Ctrl+Left";
                move-session-right = "Ctrl+Right";
                # Creates a new session with 2x2 terminal grid
                new-session-quad = "Ctrl+Shift+Up";
                # Switches between sessions
                next-session = "Ctrl+Shift+Right";
                # Switches between terminal within a session
                next-terminal = "Shift+Right";
                previous-session = "Ctrl+Shift+Left";
                previous-terminal = "Shift+Left";
                toggle-window-state = "Meta+Space";
              };

              Window = {
                DynamicTabTitles = true;
                Height = 90;
                KeepAbove = false;
                KeepOpen = true;
                ShowTabBar = true;
                ToggleToFocus = false;
                Width = 100;
              };
            };
          };

          desktop = {
            icons = {
              alignment = "left";
              arrangement = "leftToRight";
            };
          };

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
              floating = false;
              height = 40;
              hiding = "none";
              location = "bottom";

              widgets = [
                {
                  config = {
                    General = {
                      icon = "nix-snowflake-white";
                    };
                  };

                  name = "org.kde.plasma.kicker"; # or "org.kde.plasma.kickoff"
                }
                {
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

                  name = "org.kde.plasma.taskmanager";
                }
                {
                  config = {
                    expanding = true;
                  };

                  name = "org.kde.plasma.panelspacer";
                }
                {
                  config = {
                    General.displayedText = "Name";
                  };

                  name = "org.kde.plasma.pager";
                }
                {
                  config = {
                    expanding = false;
                  };

                  name = "org.kde.plasma.panelspacer";
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
                  config = {
                    Appearance = {
                      use24hFormat = true;
                    };
                  };

                  name = "org.kde.plasma.digitalclock";
                }
                "org.kde.plasma.showdesktop"
              ];
            }
          ];

          powerdevil = {
            AC = {
              autoSuspend = {
                idleTimeout = 1800;
              };

              dimKeyboard.enable = true;
              displayBrightness = 50;
              inhibitLidActionWhenExternalMonitorConnected = true;
              keyboardBrightness = 30;
              powerProfile = "balanced"; # performance, powerSaving

              turnOffDisplay = {
                idleTimeout = 600;
              };
            };

            battery = {
              autoSuspend = {
                action = "sleep";
                idleTimeout = 140;
              };

              dimDisplay = {
                enable = true;
                idleTimeout = 60;
              };

              dimKeyboard.enable = true;
              displayBrightness = 10;
              keyboardBrightness = 0;
              powerProfile = "powerSaving";

              turnOffDisplay = {
                idleTimeout = 120;
              };
            };

            batteryLevels = {
              criticalLevel = 5;
              lowLevel = 20;
            };

            general.pausePlayersOnSuspend = true;
          };

          shortcuts = {
            yakuake = {
              toggle-window-state = "Meta+Space";
            };
          };

          workspace = {
            clickItemTo = "select";
            colorScheme = "BreezeDark";
            enableMiddleClickPaste = true;

            splashScreen = {
              engine = "none";
              theme = "none";
            };

            tooltipDelay = 1;
            wallpaper = ../../../files/home/pol/Pictures/Backgrounds/Starry_Nebula_219.png;
          };
        };

        xdg.autostart.entries = [
          "${pkgs.kdePackages.yakuake}/share/applications/org.kde.yakuake.desktop"
        ];
      };
  };
}
