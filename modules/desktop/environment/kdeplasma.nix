{ inputs, ... }:
{
  flake.modules.homeManager.desktop = {
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
        colorScheme = "Breeze Dark";
        splashScreen.engine = "none";
        splashScreen.theme = "none";
        tooltipDelay = 1;
        wallpaper = ../../../files/home/pol/Pictures/Backgrounds/Starry_Nebula_219.png;
      };

      shortcuts = {
        "ActivityManager"."switch-to-activity-181b1250-1bb2-402c-9d6a-29214f2b2c3f" = [ ];
        "ActivityManager"."switch-to-activity-b04cdf06-f69b-4426-a388-d784c86899b5" = [ ];
        "ActivityManager"."switch-to-activity-c245c079-af1c-41e3-991e-31836544ee97" = [ ];
        "ActivityManager"."switch-to-activity-fc6d77d8-56ad-4801-affa-5593a61db5cc" = [ ];
        "KDE Keyboard Layout Switcher"."Switch keyboard layout to Belgian" = [ ];
        "KDE Keyboard Layout Switcher"."Switch keyboard layout to English (UK)" = [ ];
        "KDE Keyboard Layout Switcher"."Switch keyboard layout to English (US)" = [ ];
        "KDE Keyboard Layout Switcher"."Switch keyboard layout to French" = [ ];
        "KDE Keyboard Layout Switcher"."Switch keyboard layout to French (legacy, alt.)" = [ ];
        "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
        "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Meta+Alt+K";
        "kaccess"."Toggle Screen Reader On and Off" = "Meta+Alt+S";
        "kmix"."decrease_microphone_volume" = "Microphone Volume Down";
        "kmix"."decrease_volume" = "Volume Down";
        "kmix"."decrease_volume_small" = "Shift+Volume Down";
        "kmix"."increase_microphone_volume" = "Microphone Volume Up";
        "kmix"."increase_volume" = "Volume Up";
        "kmix"."increase_volume_small" = "Shift+Volume Up";
        "kmix"."mic_mute" = [
          "Microphone Mute"
          "Meta+Volume Mute,Microphone Mute"
          "Meta+Volume Mute,Mute Microphone"
        ];
        "kmix"."mute" = "Volume Mute";
        "ksmserver"."Halt Without Confirmation" = [ ];
        "ksmserver"."Lock Session" = [
          "Meta+L"
          "Ctrl+Alt+L"
          ""
          "Screensaver\\, ,Meta+L"
          "Screensaver,Lock Session"
        ];
        "ksmserver"."Log Out" = "Ctrl+Alt+Del";
        "ksmserver"."Log Out Without Confirmation" = [ ];
        "ksmserver"."LogOut" = [ ];
        "ksmserver"."Reboot" = [ ];
        "ksmserver"."Reboot Without Confirmation" = [ ];
        "ksmserver"."Shut Down" = [ ];
        "kwin"."Activate Window Demanding Attention" = "Meta+Ctrl+A";
        "kwin"."Cycle Overview" = [ ];
        "kwin"."Cycle Overview Opposite" = [ ];
        "kwin"."Decrease Opacity" = [ ];
        "kwin"."Edit Tiles" = "Meta+T";
        "kwin"."Expose" = "Ctrl+F9";
        "kwin"."ExposeAll" = [
          "Ctrl+F10"
          ""
          "Launch (C)\\, ,Ctrl+F10"
          "Launch (C),Toggle Present Windows (All desktops)"
        ];
        "kwin"."ExposeClass" = "Ctrl+F7";
        "kwin"."ExposeClassCurrentDesktop" = [ ];
        "kwin"."FlipSwitchAll" = [ ];
        "kwin"."FlipSwitchCurrent" = [ ];
        "kwin"."Grid View" = "Meta+G";
        "kwin"."Increase Opacity" = [ ];
        "kwin"."Invert Screen Colors" = [ ];
        "kwin"."Kill Window" = "Meta+Ctrl+Esc";
        "kwin"."Move Tablet to Next Output" = [ ];
        "kwin"."MoveMouseToCenter" = "Meta+F6";
        "kwin"."MoveMouseToFocus" = "Meta+F5";
        "kwin"."MoveZoomDown" = [ ];
        "kwin"."MoveZoomLeft" = [ ];
        "kwin"."MoveZoomRight" = [ ];
        "kwin"."MoveZoomUp" = [ ];
        "kwin"."Overview" = "Meta+W";
        "kwin"."Setup Window Shortcut" = [ ];
        "kwin"."Show Desktop" = "Meta+D";
        "kwin"."ShowDesktopGrid" = "Ctrl+F8\\, ,none";
        "kwin"."Suspend Compositing" = "Alt+Shift+F12\\, ,none";
        "kwin"."Switch One Desktop Down" = "\\, Meta+Ctrl+Down\\, ,Meta+Ctrl+Down,Switch One Desktop Down";
        "kwin"."Switch One Desktop Up" = "\\, Meta+Ctrl+Up\\, ,Meta+Ctrl+Up,Switch One Desktop Up";
        "kwin"."Switch One Desktop to the Left" =
          "\\, Meta+Ctrl+Left\\, ,Meta+Ctrl+Left,Switch One Desktop to the Left";
        "kwin"."Switch One Desktop to the Right" =
          "\\, Meta+Ctrl+Right\\, ,Meta+Ctrl+Right,Switch One Desktop to the Right";
        "kwin"."Switch Window Down" = "Meta+Alt+Down";
        "kwin"."Switch Window Left" = "Meta+Alt+Left";
        "kwin"."Switch Window Right" = "Meta+Alt+Right";
        "kwin"."Switch Window Up" = "Meta+Alt+Up";
        "kwin"."Switch to Desktop 1" = "Ctrl+F1";
        "kwin"."Switch to Desktop 10" = [ ];
        "kwin"."Switch to Desktop 11" = [ ];
        "kwin"."Switch to Desktop 12" = [ ];
        "kwin"."Switch to Desktop 13" = [ ];
        "kwin"."Switch to Desktop 14" = [ ];
        "kwin"."Switch to Desktop 15" = [ ];
        "kwin"."Switch to Desktop 16" = [ ];
        "kwin"."Switch to Desktop 17" = [ ];
        "kwin"."Switch to Desktop 18" = [ ];
        "kwin"."Switch to Desktop 19" = [ ];
        "kwin"."Switch to Desktop 2" = "Ctrl+F2";
        "kwin"."Switch to Desktop 20" = [ ];
        "kwin"."Switch to Desktop 3" = "Ctrl+F3";
        "kwin"."Switch to Desktop 4" = "Ctrl+F4";
        "kwin"."Switch to Desktop 5" = [ ];
        "kwin"."Switch to Desktop 6" = [ ];
        "kwin"."Switch to Desktop 7" = [ ];
        "kwin"."Switch to Desktop 8" = [ ];
        "kwin"."Switch to Desktop 9" = [ ];
        "kwin"."Switch to Next Desktop" = [ ];
        "kwin"."Switch to Next Screen" = [ ];
        "kwin"."Switch to Previous Desktop" = [ ];
        "kwin"."Switch to Previous Screen" = [ ];
        "kwin"."Switch to Screen 0" = [ ];
        "kwin"."Switch to Screen 1" = [ ];
        "kwin"."Switch to Screen 2" = [ ];
        "kwin"."Switch to Screen 3" = [ ];
        "kwin"."Switch to Screen 4" = [ ];
        "kwin"."Switch to Screen 5" = [ ];
        "kwin"."Switch to Screen 6" = [ ];
        "kwin"."Switch to Screen 7" = [ ];
        "kwin"."Switch to Screen Above" = [ ];
        "kwin"."Switch to Screen Below" = [ ];
        "kwin"."Switch to Screen to the Left" = [ ];
        "kwin"."Switch to Screen to the Right" = [ ];
        "kwin"."Toggle Night Color" = [ ];
        "kwin"."Toggle Window Raise/Lower" = [ ];
        "kwin"."ToggleCurrentThumbnail" = "Meta+Ctrl+T";
        "kwin"."Walk Through Desktop List" = [ ];
        "kwin"."Walk Through Desktop List (Reverse)" = [ ];
        "kwin"."Walk Through Desktops" = [ ];
        "kwin"."Walk Through Desktops (Reverse)" = [ ];
        "kwin"."Walk Through Windows" = [
          "Alt+Tab,Meta+Tab"
          "Alt+Tab,Walk Through Windows"
        ];
        "kwin"."Walk Through Windows (Reverse)" = [
          "Meta+Shift+Tab"
          "Alt+Shift+Tab,Meta+Shift+Tab"
          "Alt+Shift+Tab,Walk Through Windows (Reverse)"
        ];
        "kwin"."Walk Through Windows Alternative" = ",none,Walk Through Windows Alternative";
        "kwin"."Walk Through Windows Alternative (Reverse)" =
          ",none,Walk Through Windows Alternative (Reverse)";
        "kwin"."Walk Through Windows of Current Application" = [
          "\\, Alt+`\\, ,Meta+`"
          "Alt+`,Walk Through Windows of Current Application"
        ];
        "kwin"."Walk Through Windows of Current Application (Reverse)" = [
          "Alt+~,Meta+~"
          "Alt+~,Walk Through Windows of Current Application (Reverse)"
        ];
        "kwin"."Walk Through Windows of Current Application Alternative" =
          ",none,Walk Through Windows of Current Application Alternative";
        "kwin"."Walk Through Windows of Current Application Alternative (Reverse)" =
          ",none,Walk Through Windows of Current Application Alternative (Reverse)";
        "kwin"."Window Above Other Windows" = [ ];
        "kwin"."Window Below Other Windows" = [ ];
        "kwin"."Window Close" = "Alt+F4";
        "kwin"."Window Custom Quick Tile Bottom" = "none,,Custom Quick Tile Window to the Bottom";
        "kwin"."Window Custom Quick Tile Left" = "none,,Custom Quick Tile Window to the Left";
        "kwin"."Window Custom Quick Tile Right" = "none,,Custom Quick Tile Window to the Right";
        "kwin"."Window Custom Quick Tile Top" = "none,,Custom Quick Tile Window to the Top";
        "kwin"."Window Fullscreen" = [ ];
        "kwin"."Window Grow Horizontal" = [ ];
        "kwin"."Window Grow Vertical" = [ ];
        "kwin"."Window Lower" = [ ];
        "kwin"."Window Maximize" = "Meta+PgUp";
        "kwin"."Window Maximize Horizontal" = [ ];
        "kwin"."Window Maximize Vertical" = [ ];
        "kwin"."Window Minimize" = "Meta+PgDown";
        "kwin"."Window Move" = [ ];
        "kwin"."Window Move Center" = [ ];
        "kwin"."Window No Border" = [ ];
        "kwin"."Window On All Desktops" = [ ];
        "kwin"."Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
        "kwin"."Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
        "kwin"."Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
        "kwin"."Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
        "kwin"."Window One Screen Down" = [ ];
        "kwin"."Window One Screen Up" = [ ];
        "kwin"."Window One Screen to the Left" = [ ];
        "kwin"."Window One Screen to the Right" = [ ];
        "kwin"."Window Operations Menu" = "Alt+F3";
        "kwin"."Window Pack Down" = [ ];
        "kwin"."Window Pack Left" = [ ];
        "kwin"."Window Pack Right" = [ ];
        "kwin"."Window Pack Up" = [ ];
        "kwin"."Window Quick Tile Bottom" = "Meta+Down";
        "kwin"."Window Quick Tile Bottom Left" = [ ];
        "kwin"."Window Quick Tile Bottom Right" = [ ];
        "kwin"."Window Quick Tile Left" = "Meta+Left";
        "kwin"."Window Quick Tile Right" = "Meta+Right";
        "kwin"."Window Quick Tile Top" = "Meta+Up";
        "kwin"."Window Quick Tile Top Left" = [ ];
        "kwin"."Window Quick Tile Top Right" = [ ];
        "kwin"."Window Raise" = [ ];
        "kwin"."Window Resize" = [ ];
        "kwin"."Window Shade" = [ ];
        "kwin"."Window Shrink Horizontal" = [ ];
        "kwin"."Window Shrink Vertical" = [ ];
        "kwin"."Window to Desktop 1" = [ ];
        "kwin"."Window to Desktop 10" = [ ];
        "kwin"."Window to Desktop 11" = [ ];
        "kwin"."Window to Desktop 12" = [ ];
        "kwin"."Window to Desktop 13" = [ ];
        "kwin"."Window to Desktop 14" = [ ];
        "kwin"."Window to Desktop 15" = [ ];
        "kwin"."Window to Desktop 16" = [ ];
        "kwin"."Window to Desktop 17" = [ ];
        "kwin"."Window to Desktop 18" = [ ];
        "kwin"."Window to Desktop 19" = [ ];
        "kwin"."Window to Desktop 2" = [ ];
        "kwin"."Window to Desktop 20" = [ ];
        "kwin"."Window to Desktop 3" = [ ];
        "kwin"."Window to Desktop 4" = [ ];
        "kwin"."Window to Desktop 5" = [ ];
        "kwin"."Window to Desktop 6" = [ ];
        "kwin"."Window to Desktop 7" = [ ];
        "kwin"."Window to Desktop 8" = [ ];
        "kwin"."Window to Desktop 9" = [ ];
        "kwin"."Window to Next Desktop" = [ ];
        "kwin"."Window to Next Screen" = "Meta+Shift+Right";
        "kwin"."Window to Previous Desktop" = [ ];
        "kwin"."Window to Previous Screen" = "Meta+Shift+Left";
        "kwin"."Window to Screen %1" = [ ];
        "kwin"."Window to Screen 0" = [ ];
        "kwin"."Window to Screen 1" = [ ];
        "kwin"."Window to Screen 2" = [ ];
        "kwin"."Window to Screen 3" = [ ];
        "kwin"."Window to Screen 4" = [ ];
        "kwin"."Window to Screen 5" = [ ];
        "kwin"."Window to Screen 6" = [ ];
        "kwin"."Window to Screen 7" = [ ];
        "kwin"."disableInputCapture" = "Meta+Shift+Esc";
        "kwin"."view_actual_size" = ",Meta+0,Zoom to Actual Size";
        "kwin"."view_zoom_in" = [
          "Meta++"
          "Meta+=,Meta++"
          "Meta+=,Zoom In"
        ];
        "kwin"."view_zoom_out" = "Meta+-";
        "mediacontrol"."mediavolumedown" = [ ];
        "mediacontrol"."mediavolumeup" = [ ];
        "mediacontrol"."nextmedia" = "Media Next";
        "mediacontrol"."pausemedia" = "Media Pause";
        "mediacontrol"."playmedia" = [ ];
        "mediacontrol"."playpausemedia" = "Media Play";
        "mediacontrol"."previousmedia" = "Media Previous";
        "mediacontrol"."stopmedia" = "Media Stop";
        "org_kde_powerdevil"."Decrease Keyboard Brightness" = "Keyboard Brightness Down";
        "org_kde_powerdevil"."Decrease Screen Brightness" = "Monitor Brightness Down";
        "org_kde_powerdevil"."Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
        "org_kde_powerdevil"."Hibernate" = "Hibernate";
        "org_kde_powerdevil"."Increase Keyboard Brightness" = "Keyboard Brightness Up";
        "org_kde_powerdevil"."Increase Screen Brightness" = "Monitor Brightness Up";
        "org_kde_powerdevil"."Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
        "org_kde_powerdevil"."PowerDown" = "Power Down";
        "org_kde_powerdevil"."PowerOff" = "Power Off";
        "org_kde_powerdevil"."Sleep" = "Sleep";
        "org_kde_powerdevil"."Toggle Keyboard Backlight" = "Keyboard Light On/Off";
        "org_kde_powerdevil"."Turn Off Screen" = [ ];
        "org_kde_powerdevil"."powerProfile" = [
          "Battery"
          ""
          "Meta+B\\, ,Battery"
          "Meta+B,Switch Power Profile"
        ];
        "plasmashell"."activate application launcher" = [
          "Meta"
          ""
          "Alt+F1\\, ,Meta"
          "Alt+F1,Activate Application Launcher"
        ];
        "plasmashell"."activate task manager entry 1" = "Meta+1";
        "plasmashell"."activate task manager entry 10" = "\\, Meta+0\\, ,,Activate Task Manager Entry 10";
        "plasmashell"."activate task manager entry 2" = "Meta+2";
        "plasmashell"."activate task manager entry 3" = "Meta+3";
        "plasmashell"."activate task manager entry 4" = "Meta+4";
        "plasmashell"."activate task manager entry 5" = "Meta+5";
        "plasmashell"."activate task manager entry 6" = "Meta+6";
        "plasmashell"."activate task manager entry 7" = "Meta+7";
        "plasmashell"."activate task manager entry 8" = "Meta+8";
        "plasmashell"."activate task manager entry 9" = "Meta+9";
        "plasmashell"."clear-history" = "\\, ,,Clear Clipboard History";
        "plasmashell"."clipboard_action" = "Meta+Ctrl+X";
        "plasmashell"."cycle-panels" = "Meta+Alt+P";
        "plasmashell"."cycleNextAction" = [ ];
        "plasmashell"."cyclePrevAction" = [ ];
        "plasmashell"."edit_clipboard" = "none,,Edit Contents…";
        "plasmashell"."manage activities" = "\\, Meta+Q\\, ,Meta+Q,Show Activity Switcher";
        "plasmashell"."next activity" = [ ];
        "plasmashell"."previous activity" = [ ];
        "plasmashell"."repeat_action" = [ ];
        "plasmashell"."show dashboard" = "Ctrl+F12";
        "plasmashell"."show-barcode" = [ ];
        "plasmashell"."show-on-mouse-pos" = "\\, Meta+V\\, ,Meta+V,Show Clipboard Items at Mouse Position";
        "plasmashell"."stop current activity" = "\\, Meta+S\\, ,Meta+S,Stop Current Activity";
        "plasmashell"."switch to next activity" = [ ];
        "plasmashell"."switch to previous activity" = [ ];
        "plasmashell"."toggle do not disturb" = [ ];
        "services/krunner.desktop"."RunClipboard" = "Alt+Shift+F2";
        "services/krunner.desktop"."_launch" = [
          ""
          ""
          ""
          "Alt+Space"
          "Alt+F2"
          "Search"
          ""
          "Alt+Space"
          "Alt+F2"
          "Search"
          ""
          ""
          "Alt+Space"
          "Alt+F2"
          "Search"
          ""
          "Alt+Space"
          "Alt+F2"
          "Search"
        ];
        "services/org.kde.krunner.desktop"."RunClipboard" = [ ];
        "services/org.kde.krunner.desktop"."_launch" = [ ];
        "services/org.kde.plasma-systemmonitor.desktop"."_launch" = "Ctrl+Esc";
        "services/org.kde.plasma.emojier.desktop"."_launch" = "Meta+.";
        "services/org.kde.spectacle.desktop"."RecordWindow" = [ ];
        "services/services.krunner.desktop"."RunClipboard" = "Alt+Shift+F2";
        "services/services.krunner.desktop"."_launch" = [
          ""
          ""
          ""
          "Alt+Space"
          "Alt+F2"
          "Search"
          ""
          "Alt+Space"
          "Alt+F2"
          "Search"
          ""
          ""
          "Alt+Space"
          "Alt+F2"
          "Search"
          ""
          "Alt+Space"
          "Alt+F2"
          "Search"
        ];
        "services/services.org.kde.krunner.desktop"."RunClipboard" = [ ];
        "services/services.org.kde.krunner.desktop"."_launch" = [ ];
        "services/services.org.kde.plasma-systemmonitor.desktop"."_launch" = "Ctrl+Esc";
        "services/services.org.kde.plasma.emojier.desktop"."_launch" = "Meta+.";
        "yakuake"."toggle-window-state" = [
          "Meta+Space"
          "F12\\, F12\\, ,F12,Open/Retract Yakuake"
        ];
      };
      configFile = {
        "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
        "baloofilerc"."General"."dbVersion" = 2;
        "baloofilerc"."General"."exclude filters" =
          "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,core-dumps,lost+found";
        "baloofilerc"."General"."exclude filters version" = 8;
        "baloofilerc"."General"."exclude foldersx5b$ex5d" = "$HOME/";
        "baloofilerc"."General"."index hidden folders" = true;
        "baloofilerc"."General"."only basic indexing" = true;
        "dolphinrc"."Desktop Entry"."DefaultProfile" = "";
        "dolphinrc"."DetailsMode"."PreviewSize" = 22;
        "dolphinrc"."General"."ViewPropsTimestamp" = "2024,7,2,21,58,57.224";
        "dolphinrc"."IconsMode"."PreviewSize" = 224;
        "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
        "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
        "dolphinrc"."Open-with settings"."CompletionMode" = 1;
        "dolphinrc"."Open-with settings"."History" = "visu,visual";
        "dolphinrc"."Search"."Location" = "Everywhere";
        "dolphinrc"."Search"."What" = "Content";
        "dolphinrc"."SettingsDialog"."eDP-1 Height 1920x1080" = 440;
        "dolphinrc"."SettingsDialog"."eDP-1 Width 1920x1080" = 585;
        "kactivitymanagerdrc"."activities"."181b1250-1bb2-402c-9d6a-29214f2b2c3f" = "NixOS Desktop";
        "kactivitymanagerdrc"."activities-descriptions"."181b1250-1bb2-402c-9d6a-29214f2b2c3f" =
          "NixOS Desktop";
        "kactivitymanagerdrc"."activities-icons"."181b1250-1bb2-402c-9d6a-29214f2b2c3f" = "nix-snowflake";
        "kactivitymanagerdrc"."main"."currentActivity" = "181b1250-1bb2-402c-9d6a-29214f2b2c3f";
        "kactivitymanagerdrc"."main"."runningActivities" = "181b1250-1bb2-402c-9d6a-29214f2b2c3f";
        "kactivitymanagerdrc"."main"."stoppedActivities" = "";
        "katerc"."General"."Days Meta Infos" = 30;
        "katerc"."General"."Save Meta Infos" = true;
        "katerc"."General"."Show Full Path in Title" = false;
        "katerc"."General"."Show Menu Bar" = true;
        "katerc"."General"."Show Status Bar" = true;
        "katerc"."General"."Show Tab Bar" = true;
        "katerc"."General"."Show Url Nav Bar" = true;
        "katerc"."KTextEditor Renderer"."Animate Bracket Matching" = false;
        "katerc"."KTextEditor Renderer"."Auto Color Theme Selection" = true;
        "katerc"."KTextEditor Renderer"."Color Theme" = "Breeze Dark";
        "katerc"."KTextEditor Renderer"."Line Height Multiplier" = 1;
        "katerc"."KTextEditor Renderer"."Show Indentation Lines" = false;
        "katerc"."KTextEditor Renderer"."Show Whole Bracket Expression" = false;
        "katerc"."KTextEditor Renderer"."Text Font" =
          "Aporetic Sans Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
        "katerc"."KTextEditor Renderer"."Text Font Features" = "";
        "katerc"."KTextEditor Renderer"."Word Wrap Marker" = false;
        "katerc"."KTextEditor::Search"."Search History" = "trainer.,pylanc";
        "katerc"."filetree"."editShade" = "31,81,106";
        "katerc"."filetree"."listMode" = false;
        "katerc"."filetree"."middleClickToClose" = false;
        "katerc"."filetree"."shadingEnabled" = true;
        "katerc"."filetree"."showCloseButton" = false;
        "katerc"."filetree"."showFullPathOnRoots" = false;
        "katerc"."filetree"."showToolbar" = true;
        "katerc"."filetree"."sortRole" = 0;
        "katerc"."filetree"."viewShade" = "81,49,95";
        "kcminputrc"."Keyboard"."KeyRepeat" = "repeat";
        "kcminputrc"."Keyboard"."NumLock" = 2;
        "kcminputrc"."Keyboard"."RepeatDelay" = 600;
        "kcminputrc"."Keyboard"."RepeatRate" = 25;
        "kcminputrc"."Libinput.2.10.TPPS\\/2 IBM TrackPoint"."MiddleButtonEmulation" = true;
        "kcminputrc"."Libinput/2/10/TPPS\\/2 IBM TrackPoint"."MiddleButtonEmulation" = true;
        "kcminputrc"."Libinput/2/16/TPPS\\/2 IBM TrackPoint"."MiddleButtonEmulation" = true;
        "kcminputrc"."Mouse"."X11LibInputXAccelProfileFlat" = false;
        "kcminputrc"."Mouse"."XLbInptAccelProfileFlat" = false;
        "kcminputrc"."Mouse"."XLbInptPointerAcceleration" = 0;
        "kcminputrc"."Tmp"."update_info" = "delete_cursor_old_default_size.upd:DeleteCursorOldDefaultSize";
        "kded5rc"."Module-browserintegrationreminder"."autoload" = false;
        "kded5rc"."Module-device_automounter"."autoload" = false;
        "kded5rc"."PlasmaBrowserIntegration"."shownCount" = 3;
        "kdeglobals"."DirSelect Dialog"."DirSelectDialog Size" = "825,584";
        "kdeglobals"."DirSelect Dialog"."Splitter State" =
          "\x00\x00\x00\xff\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x91\x00\x00\x02\xa8\x00\xff\xff\xff\xff\x01\x00\x00\x00\x01\x00";
        "kdeglobals"."General"."AllowKDEAppsToRememberWindowPositions" = true;
        "kdeglobals"."General"."BrowserApplication" = "firefox.desktop";
        "kdeglobals"."General"."XftHintStyle" = "hintslight";
        "kdeglobals"."General"."XftSubPixel" = "none";
        "kdeglobals"."General"."fixed" = "Aporetic Sans Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
        "kdeglobals"."General"."font" = "Aporetic Sans Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
        "kdeglobals"."General"."menuFont" = "Aporetic Sans Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
        "kdeglobals"."General"."smallestReadableFont" =
          "Aporetic Sans Mono,8,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
        "kdeglobals"."General"."toolBarFont" = "Aporetic Sans Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
        "kdeglobals"."KDE"."AnimationDurationFactor" = 0.25;
        "kdeglobals"."KDE"."SingleClick" = false;
        "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
        "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
        "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
        "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
        "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
        "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
        "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
        "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
        "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
        "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
        "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
        "kdeglobals"."KFileDialog Settings"."Show hidden files" = false;
        "kdeglobals"."KFileDialog Settings"."Sort by" = "Date";
        "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
        "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
        "kdeglobals"."KFileDialog Settings"."Sort reversed" = true;
        "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 105;
        "kdeglobals"."KFileDialog Settings"."View Style" = "Simple";
        "kdeglobals"."KScreen"."ScreenScaleFactors" = "eDP-1\x3d1;DP-3\x3d1;";
        "kdeglobals"."KShortcutsDialog Settings"."Dialog Size" = "876,614";
        "kdeglobals"."WM"."activeBackground" = "49,54,59";
        "kdeglobals"."WM"."activeBlend" = "252,252,252";
        "kdeglobals"."WM"."activeFont" = "Aporetic Sans Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
        "kdeglobals"."WM"."activeForeground" = "252,252,252";
        "kdeglobals"."WM"."inactiveBackground" = "42,46,50";
        "kdeglobals"."WM"."inactiveBlend" = "161,169,177";
        "kdeglobals"."WM"."inactiveForeground" = "161,169,177";
        "kgammarc"."ConfigFile"."use" = "kgammarc";
        "khotkeysrc"."Data"."DataCount" = 1;
        "khotkeysrc"."Data_1"."Comment" = "KMenuEdit Global Shortcuts";
        "khotkeysrc"."Data_1"."DataCount" = 0;
        "khotkeysrc"."Data_1"."Enabled" = true;
        "khotkeysrc"."Data_1"."Name" = "KMenuEdit";
        "khotkeysrc"."Data_1"."SystemGroup" = 1;
        "khotkeysrc"."Data_1"."Type" = "ACTION_DATA_GROUP";
        "khotkeysrc"."Data_1Conditions"."Comment" = "";
        "khotkeysrc"."Data_1Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."DirSelect Dialog"."DirSelectDialog Sizex5b$dx5d" = "";
        "khotkeysrc"."General"."AllowKDEAppsToRememberWindowPositionsx5b$dx5d" = "";
        "khotkeysrc"."General"."BrowserApplicationx5b$dx5d" = "";
        "khotkeysrc"."General"."ColorSchemeHashx5b$dx5d" = "";
        "khotkeysrc"."General"."ColorSchemex5b$dx5d" = "";
        "khotkeysrc"."General"."XftHintStylex5b$dx5d" = "";
        "khotkeysrc"."General"."XftSubPixelx5b$dx5d" = "";
        "khotkeysrc"."General"."fixedx5b$dx5d" = "";
        "khotkeysrc"."General"."fontx5b$dx5d" = "";
        "khotkeysrc"."General"."menuFontx5b$dx5d" = "";
        "khotkeysrc"."General"."smallestReadableFontx5b$dx5d" = "";
        "khotkeysrc"."General"."toolBarFontx5b$dx5d" = "";
        "khotkeysrc"."Gestures"."Disabled" = true;
        "khotkeysrc"."Gestures"."MouseButton" = 2;
        "khotkeysrc"."Gestures"."Timeout" = 300;
        "khotkeysrc"."GesturesExclude"."Comment" = "";
        "khotkeysrc"."GesturesExclude"."WindowsCount" = 0;
        "khotkeysrc"."Icons"."Themex5b$dx5d" = "";
        "khotkeysrc"."KDE"."AnimationDurationFactorx5b$dx5d" = "";
        "khotkeysrc"."KDE"."LookAndFeelPackagex5b$dx5d" = "";
        "khotkeysrc"."KDE"."SingleClickx5b$dx5d" = "";
        "khotkeysrc"."KDE"."widgetStylex5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Allow Expansionx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Automatically select filename extensionx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Breadcrumb Navigationx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Decoration positionx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."LocationCombo Completionmodex5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."PathCombo Completionmodex5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show Bookmarksx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show Full Pathx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show Inline Previewsx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show Previewx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show Speedbarx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show hidden filesx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Sort byx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Sort directories firstx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Sort hidden files lastx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Sort reversedx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Speedbar Widthx5b$dx5d" = "";
        "khotkeysrc"."KFileDialog Settings"."View Stylex5b$dx5d" = "";
        "khotkeysrc"."KShortcutsDialog Settings"."Dialog Sizex5b$dx5d" = "";
        "khotkeysrc"."Main"."AlreadyImported" = "defaults,kde32b1,konqueror_gestures_kde321,konsole";
        "khotkeysrc"."Main"."Disabled" = false;
        "khotkeysrc"."Voice"."Shortcut" = "";
        "khotkeysrc"."WM"."activeBackgroundx5b$dx5d" = "";
        "khotkeysrc"."WM"."activeBlendx5b$dx5d" = "";
        "khotkeysrc"."WM"."activeFontx5b$dx5d" = "";
        "khotkeysrc"."WM"."activeForegroundx5b$dx5d" = "";
        "khotkeysrc"."WM"."inactiveBackgroundx5b$dx5d" = "";
        "khotkeysrc"."WM"."inactiveBlendx5b$dx5d" = "";
        "khotkeysrc"."WM"."inactiveForegroundx5b$dx5d" = "";
        "kiorc"."Confirmations"."ConfirmDelete" = false;
        "kiorc"."Confirmations"."ConfirmEmptyTrash" = true;
        "klaunchrc"."BusyCursorSettings"."Bouncing" = false;
        "klaunchrc"."FeedbackStyle"."BusyCursor" = false;
        "krunnerrc"."General"."historyBehavior" = "ImmediateCompletion";
        "krunnerrc"."Plugins"."CharacterRunnerEnabled" = true;
        "krunnerrc"."Plugins"."DictionaryEnabled" = false;
        "krunnerrc"."Plugins"."Kill RunnerEnabled" = true;
        "krunnerrc"."Plugins"."PassEnabled" = true;
        "krunnerrc"."Plugins"."PowerDevilEnabled" = true;
        "krunnerrc"."Plugins"."Spell CheckerEnabled" = true;
        "krunnerrc"."Plugins"."appstreamEnabled" = false;
        "krunnerrc"."Plugins"."baloosearchEnabled" = true;
        "krunnerrc"."Plugins"."bookmarksEnabled" = true;
        "krunnerrc"."Plugins"."browserhistoryEnabled" = true;
        "krunnerrc"."Plugins"."browsertabsEnabled" = true;
        "krunnerrc"."Plugins"."calculatorEnabled" = true;
        "krunnerrc"."Plugins"."desktopsessionsEnabled" = true;
        "krunnerrc"."Plugins"."katesessionsEnabled" = true;
        "krunnerrc"."Plugins"."konsoleprofilesEnabled" = true;
        "krunnerrc"."Plugins"."kwinEnabled" = true;
        "krunnerrc"."Plugins"."locationsEnabled" = true;
        "krunnerrc"."Plugins"."org.kde.activitiesEnabled" = true;
        "krunnerrc"."Plugins"."org.kde.datetimeEnabled" = true;
        "krunnerrc"."Plugins"."org.kde.windowedwidgetsEnabled" = true;
        "krunnerrc"."Plugins"."placesEnabled" = true;
        "krunnerrc"."Plugins"."plasma-desktopEnabled" = true;
        "krunnerrc"."Plugins"."recentdocumentsEnabled" = true;
        "krunnerrc"."Plugins"."servicesEnabled" = true;
        "krunnerrc"."Plugins"."shellEnabled" = true;
        "krunnerrc"."Plugins"."unitconverterEnabled" = true;
        "krunnerrc"."Plugins"."webshortcutsEnabled" = true;
        "krunnerrc"."Plugins"."windowsEnabled" = true;
        "kscreenlockerrc"."Daemon"."Timeout" = 15;
        "ksmserverrc"."SubSession: 9bf60ab2-2e77-4ef0-945f-1713bcdbd756"."count" = 0;
        "ksmserverrc"."SubSession: b04cdf06-f69b-4426-a388-d784c86899b5"."count" = 0;
        "ksplashrc"."KSplash"."Engine" = "none";
        "ksplashrc"."KSplash"."Theme" = "none";
        "kwalletrc"."Wallet"."First Use" = false;
        "kwinrc"."Compositing"."OpenGLIsUnsafe" = false;
        "kwinrc"."Desktops"."Id_1" = "a1941d3b-435b-4b34-b4cf-3f14379a2361";
        "kwinrc"."Desktops"."Number" = 1;
        "kwinrc"."Desktops"."Rows" = 1;
        "kwinrc"."DrmOutputs.bd455426-91b5-5aa4-b78c-9e21c3c810ab.bd455426-91b5-5aa4-b78c-9e21c3c810ab"."Mode" =
          "1920x1080_60049";
        "kwinrc"."DrmOutputs.bd455426-91b5-5aa4-b78c-9e21c3c810ab.bd455426-91b5-5aa4-b78c-9e21c3c810ab"."Scale" =
          1;
        "kwinrc"."DrmOutputs.bd455426-91b5-5aa4-b78c-9e21c3c810ab.bd455426-91b5-5aa4-b78c-9e21c3c810ab"."Transform" =
          "normal";
        "kwinrc"."DrmOutputs/bd455426-91b5-5aa4-b78c-9e21c3c810ab/bd455426-91b5-5aa4-b78c-9e21c3c810ab"."Mode" =
          "1920x1080_60049";
        "kwinrc"."DrmOutputs/bd455426-91b5-5aa4-b78c-9e21c3c810ab/bd455426-91b5-5aa4-b78c-9e21c3c810ab"."Scale" =
          1;
        "kwinrc"."DrmOutputs/bd455426-91b5-5aa4-b78c-9e21c3c810ab/bd455426-91b5-5aa4-b78c-9e21c3c810ab"."Transform" =
          "normal";
        "kwinrc"."Effect-DesktopGrid"."DesktopNameAlignment" = 132;
        "kwinrc"."Effect-DimInactive"."Strength" = 10;
        "kwinrc"."Effect-Overview"."BorderActivate" = 1;
        "kwinrc"."Effect-PresentWindows"."BorderActivateAll" = 9;
        "kwinrc"."Effect-PresentWindows"."BorderActivateClass" = 2;
        "kwinrc"."Effect-PresentWindows"."LayoutMode" = 1;
        "kwinrc"."Effect-PresentWindows"."ShowPanel" = true;
        "kwinrc"."Effect-diminactive"."DimDesktop" = true;
        "kwinrc"."Effect-diminactive"."DimKeepAbove" = true;
        "kwinrc"."Effect-diminactive"."DimPanels" = true;
        "kwinrc"."ElectricBorders"."BottomRight" = "ShowDesktop";
        "kwinrc"."MouseBindings"."CommandActiveTitlebar2" = "Toggle raise and lower";
        "kwinrc"."MouseBindings"."CommandInactiveTitlebar2" = "Toggle raise and lower";
        "kwinrc"."Plugins"."blurEnabled" = false;
        "kwinrc"."Plugins"."cubeEnabled" = false;
        "kwinrc"."Plugins"."desktopgridEnabled" = false;
        "kwinrc"."Plugins"."diminactiveEnabled" = false;
        "kwinrc"."Plugins"."dimscreenEnabled" = false;
        "kwinrc"."Plugins"."fadeEnabled" = false;
        "kwinrc"."Plugins"."fadedesktopEnabled" = false;
        "kwinrc"."Plugins"."fallapartEnabled" = false;
        "kwinrc"."Plugins"."frozenappEnabled" = false;
        "kwinrc"."Plugins"."glideEnabled" = false;
        "kwinrc"."Plugins"."kwin4_effect_dialogparentEnabled" = false;
        "kwinrc"."Plugins"."kwin4_effect_fadingpopupsEnabled" = false;
        "kwinrc"."Plugins"."kwin4_effect_morphingpopupsEnabled" = false;
        "kwinrc"."Plugins"."kwin4_effect_translucencyEnabled" = true;
        "kwinrc"."Plugins"."magiclampEnabled" = false;
        "kwinrc"."Plugins"."overviewEnabled" = true;
        "kwinrc"."Plugins"."scaleEnabled" = false;
        "kwinrc"."Plugins"."shakecursorEnabled" = false;
        "kwinrc"."Plugins"."sheetEnabled" = true;
        "kwinrc"."Plugins"."showfpsEnabled" = false;
        "kwinrc"."Plugins"."slideEnabled" = false;
        "kwinrc"."Plugins"."slidebackEnabled" = false;
        "kwinrc"."Plugins"."slidingpopupsEnabled" = false;
        "kwinrc"."Plugins"."snaphelperEnabled" = false;
        "kwinrc"."Plugins"."squashEnabled" = false;
        "kwinrc"."Plugins"."thumbnailasideEnabled" = true;
        "kwinrc"."Plugins"."translucencyEnabled" = false;
        "kwinrc"."Plugins"."wobblywindowsEnabled" = false;
        "kwinrc"."ScreenEdges"."RemainActiveOnFullscreen" = true;
        "kwinrc"."SubSession: 9bf60ab2-2e77-4ef0-945f-1713bcdbd756"."active" = "-1";
        "kwinrc"."SubSession: 9bf60ab2-2e77-4ef0-945f-1713bcdbd756"."count" = 0;
        "kwinrc"."SubSession: b04cdf06-f69b-4426-a388-d784c86899b5"."count" = 0;
        "kwinrc"."TabBox"."BorderActivate" = 9;
        "kwinrc"."TabBox"."BorderAlternativeActivate" = 6;
        "kwinrc"."Tiling"."padding" = 4;
        "kwinrc"."Tiling.213a9620-187e-58a6-b80b-85d8fb95dfce"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5854166666666671},{\"layoutDirection\":\"vertical\",\"tiles\":[{\"height\":0.5},{\"height\":0.5}],\"width\":0.41458333333333286}]}";
        "kwinrc"."Tiling.23ae3a8b-4cf4-515e-9c19-24b391246a0f"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling.41e80e0d-6e0e-557b-8a90-a4fafca659fd"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling.5b7a5ba4-43cc-5910-8e98-f358f9d54b43"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling.ff51ace0-88bb-54af-9479-58ed034df9d9"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5},{\"width\":0.5}]}";
        "kwinrc"."Tiling/01821215-c5eb-5a7d-b447-b724c603acef"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/01dbfba4-436a-53cb-ab87-922fbc62a69c"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/027410f6-ed9e-5e32-9991-042825800a73"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/03e6f8b6-ad3b-555c-a022-efd290e473c5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/06e592f4-0639-5b2e-a350-b46c6cd79976"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/08fe3223-9046-5232-ab81-485ad69670e3"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/09d3007a-f68e-5822-ad60-e87514665af4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/0bcc325b-ff3c-5f91-bc4b-1c9c2125d097"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/0c08681c-a99f-5f7c-9b9c-370d07f6eba5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/0ddaa0b8-3e7b-5719-ac64-d9002a058a8c"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/0fcd557b-4ad5-5452-aa53-30b710f065fe"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/101eb155-0f7e-593c-a254-80eb120b3a15"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/10784c58-6902-5f25-a8f7-11d60f6a986a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/10a0e164-022e-5e32-8965-1891942e49cb"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/10e99ef8-e294-5889-a737-597d979f068f"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/114b7ccc-efca-5b50-bc7c-0183730c0ca6"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/13579f57-3a68-5d02-b7b3-7e2b85dec6d5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/13be242b-0f14-5f19-997a-37436a724614"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/190411f6-46ba-51da-bad4-3ccdb9d3b47a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/1a73fc26-760a-5022-acc0-f05425cbc853"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/1fdb9895-7960-51a3-ba35-15aaab2e31f4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/1ff3f2c8-07d7-568d-bfba-5ffc27ce9a8f"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/213a9620-187e-58a6-b80b-85d8fb95dfce"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5854166666666671},{\"layoutDirection\":\"vertical\",\"tiles\":[{\"height\":0.5},{\"height\":0.5}],\"width\":0.41458333333333286}]}";
        "kwinrc"."Tiling/21bc033f-27c0-5a26-a300-7d6ea2d06bab"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/22f7da7f-5e78-5de2-93bb-a99e78cf9c88"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/22f9a0d6-a0d2-5f1e-8c18-2688b03eebce"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/2329d4df-d4b3-537e-abee-aa16206ca3a5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/232e1435-7d00-5c4c-af8e-10eb866334d9"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/23ae3a8b-4cf4-515e-9c19-24b391246a0f"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/25d94789-787d-59c4-8b20-7a4f74a82713"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/2852b5a7-a246-55db-9a19-fb17f333a54d"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/28e2a3e3-1978-5f28-ab34-268392f47b51"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/2975b5a6-0c4f-53aa-a86d-c7a09017b605"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"layoutDirection\":\"vertical\",\"tiles\":[{\"height\":0.5},{\"height\":0.5}],\"width\":0.5},{\"width\":0.5}]}";
        "kwinrc"."Tiling/29cd54b1-0ece-5edb-895d-ea0b00f8c30f"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/29f0f879-92ee-51dd-bead-cda5ec38ce9f"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/2b3ceef7-9fb6-5b6e-afc3-4334faab9450"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/2c6e7bb5-8c9a-5df3-94dc-91ddc2b72d3c"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/2d6d7c5e-b6af-5bb1-91c8-9e6b2c0d00ca"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/2ddf7232-2469-5be2-9b3e-e26b685b5e26"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/2f01f6fa-a840-55c6-a6f5-fdc7f9b1cf67"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/2f46f3df-c138-523c-b720-2cf241cd8878"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/323cf99e-ec32-53f9-9144-fb8cf81b70c4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/325f4145-9131-510c-b54b-a63009fd0808"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/328e862a-7f66-570a-8ba0-fbc4b024f00d"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/36567587-77a3-53e6-8edd-ace45ce9dd23"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/3694e9eb-ebe1-5be5-8c7c-aebff8c73898"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/39e67734-a788-5ae9-8700-0390d661561c"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/3a89bf7f-bd05-52bb-a315-d5601d5cfa16"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/3ae1e3ee-7481-513e-b231-11b8b73d62f4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/3b2cbfbd-05d0-52aa-9251-da2095181135"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/3b4b155c-3d2d-5ac1-b2ea-763a7cc6f9e8"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/3e30a286-c29e-56d5-8596-0cbb33a7d88f"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/3e8bff49-b594-56b6-bd2b-67e49af20180"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/3f34d9cb-534f-5a02-a830-ee9f937b7743"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/3f3c104e-5206-5c43-bf1b-a46b3e69d8ca"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/411dc4f3-903d-55a5-8f88-926eddfd941d"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/41875d65-9d46-5a24-b2a1-d6ac9bdc6363"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/41e80e0d-6e0e-557b-8a90-a4fafca659fd"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/42634965-7336-5aca-befb-3bc68e98ef33"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/44cfa0ba-ae4b-5d21-a52b-1584922652ba"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/466c46cc-38c9-5d0f-b917-31679aa0953d"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/46dba445-cef9-5357-82a5-022d020a78d1"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/4867a3a8-0b2b-503f-988d-f74dd63dc8e5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/49349ed5-a8f4-5105-8739-175bcc9c22a7"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/49c8d4f9-d401-5d7b-9848-24d8108bcebe"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/4f4c9106-3bb9-5a39-93bd-a1b80abb6fa3"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/4f4f7a57-2736-576a-815b-907136ab6c80"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/4fd33090-0e53-595d-89e5-add07aead641"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/500e94ae-95df-5e53-b53d-939a042a513c"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/507a76a5-0609-5a68-9ce4-85fbfde5672e"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/50a578ba-fcf3-5ca7-b21f-34d832b28e27"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/50e4c005-a3b7-5030-b7a0-778a65e0cb68"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/5182a633-4d26-5eff-af32-cddbbf66cc9d"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/52243872-d575-54bc-ba46-435cfb8ac7df"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/52d11e28-3221-53e8-bde8-b496226053c7"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/53a05986-3ec9-5d6f-b1a7-7acdf7a11e07"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/554d163c-1cca-50f3-83ce-b2a152d20ad8"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/58217ffb-7493-58f7-a6d0-40defadad790"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/59e6b77d-0dc1-5d59-a038-fec9aec4ca81"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/5aaff381-1a4c-594c-8ec9-40df43a047cf"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/5b04aace-7938-55f5-8e8d-25a21399df35"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/5b53dc67-d50e-5587-ae46-b879087b702f"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/5b7a5ba4-43cc-5910-8e98-f358f9d54b43"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/5c8c401e-9382-5105-b42f-fa8a0647f0ee"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/5ced05e4-8f6f-5e78-a2b6-6f85be17b684"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/5e7771ef-c768-5854-a78a-3170bd76d373"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/614092be-b127-584a-b315-3ac87eabff3a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/628e1af5-667e-5121-96fd-afcf5633296d"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/62b48fa0-8638-5b99-bbd5-9599042d5bca"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/62d79e45-3887-5f59-9037-6c91a8cf50c1"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/637236e9-07c1-51f9-97f2-a92fc416073b"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/64837fab-5010-5128-8b64-21690150a0f5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/6637430b-d517-5e97-b01d-9a0ea0a2a8ff"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/665a6e20-a185-5406-88df-14452dc3c211"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/693aa8f5-f049-5508-8c0a-6a148732cbc0"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/6bec2a62-4cbc-56fd-a56f-fb754067a714"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/6dafe798-6a71-5d6a-ad71-bf9e2b7a0e4a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/6e8b7015-6562-5421-9762-6323dbc36890"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/704cb693-0170-5b8f-9756-7223a8d8e75b"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/708dbcc8-21bf-539f-b06d-9e334227837c"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/724a8edb-4270-54ce-af34-7c8c339385c5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/760f978a-07d0-50ef-9a4d-11f2984e19aa"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/78a08d6a-546d-5c26-bda9-3556bb66f740"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/7c62c0d9-3831-5128-b875-b97e4c79d98d"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/7de5f9d2-4122-58e4-9742-b19cf732174c"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/81ddbfaf-0528-5688-aecf-d0c9a6a112b4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/81fc61ce-488b-51c3-95ce-2842b0409efe"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/82251085-51c3-50e6-b740-7c431a570c42"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/82ce960b-f9b3-59cb-8af3-1615e183b4e4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/86d0be1c-332d-5f7e-89e5-f1db5d6708aa"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/8a79993b-59d4-5cef-b96e-8e9581b70463"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/8b9ba09a-a222-5109-853c-af6c8b5ec873"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/8be9fb61-3d3a-51f2-a11d-c7276bdb079d"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.6305232558139536},{\"width\":0.36947674418604637}]}";
        "kwinrc"."Tiling/8c13094f-be44-5cfa-b7d5-822f2175f83e"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/8d7250d5-5770-53ad-8aaa-23eab01cba21"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/8dddbdc8-ebe0-510f-b4ee-93b1f31c8749"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/8f8b707c-97bd-5292-8d22-879b3058e4a8"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/92a632b6-63e1-5f33-9300-a00b10b9801a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/92f1f6cf-3d03-5b3b-91b9-e0ff4de2fb6d"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/9370699a-59ac-5189-9f8f-5161863dddb5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/93c6c875-41d1-517d-8d3c-e438d25a415e"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/93eea6d9-960b-5b5b-8fdb-d27996603318"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/9537898f-cee0-5fe7-a12c-c0cfd0f9607b"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/95d0f558-3ac9-578f-b0d9-6d2d35c10f92"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/9948fa60-a43a-58a5-a65a-af79ded00040"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/9cb15cf7-1af7-55b8-bc46-d1d6194fa432"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/9f40d391-6b5b-5f46-9afb-4b1827cd02b1"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a0ae473b-ce90-5b68-a474-c18c85cfdfe6"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/03614c7b-ec02-4d70-bcda-3f1ca2fac863"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/2162a9f5-0c53-4a63-af08-1fdc717c976e"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/2dfb4c5e-2429-4eeb-9522-477cf3187ed4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5},{\"width\":0.5}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/2eaec272-2a5b-45a0-b24d-c6c2d5606230"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/39ad61e9-e372-466a-81c2-720f306f17d1"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/53c41be9-e90b-429f-be50-54dcf718ee60"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/6e7b1b20-7b76-43e6-bded-d820f735af09"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5},{\"width\":0.5}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/7beace48-51e0-4732-ae01-7a3f8c94b6b6"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5},{\"width\":0.5}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/7e201411-4174-4085-993b-aceb29bd463e"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/82105abb-7b9d-4af2-a9e1-f4821441a2c9"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/8323eb6d-0105-4ee7-bb6d-c3171a482e17"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/8f181034-ac61-405f-a484-43a080236845"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5},{\"width\":0.5}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/8fec064b-a93f-467b-9cd5-aef18d4fcad1"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/abc84094-63a3-407f-bec3-bda53466e204"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/b25fd7b6-aacf-45ad-97af-c78e37a07ba5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5},{\"width\":0.5}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/b79cb133-a8f7-415c-97ad-dc0a732d25c0"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/c5c1d4ad-0d84-43d4-8d56-c310ebf197cf"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/cc5f56c0-90fb-4a17-ade8-aeacd1c9c3ee"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/cd8180c3-6a76-4b9b-88a4-78f8946901bc"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/d4007100-f955-485d-8020-fddfecba5489"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/e1c060cd-d34b-4bfd-abaf-97882efb6c3c"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5},{\"width\":0.5}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/f68e00e1-b45f-4fba-80dd-4b6b4fea7a0c"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5},{\"width\":0.5}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/f75428a7-5ef6-455f-9de6-50ec7cdf0116"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a1941d3b-435b-4b34-b4cf-3f14379a2361/f904952e-188c-4c0e-8e89-fe287739e43a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a2a76eb9-4db3-5bb9-a677-2b3d209541f2"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a2bae53e-5fe9-5391-b806-8847a01ca27a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a2d36cba-14dc-5500-a878-b272568874d8"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/a945d064-5fbb-59e1-a888-67aa62fab74d"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/ab419330-52c2-51de-b0bb-e654fe622bd7"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/ae1a9bba-a4de-5a97-9a94-58dbd6b96412"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/af628b49-50cd-5ad1-8932-2a5e6e96a208"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/b20678f1-6dc7-5cab-ba81-36a48f0c27ec"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/b211b00c-c201-546b-b15a-6a8cb0591708"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/b4d4cc3c-782b-5628-ac25-448a0335d16a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/b60fd221-1999-55e9-9e28-5d4f4489faaf"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/b6626f98-a153-5f33-b09e-fc7b72791366"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/b731f09f-83c4-59f9-be6b-e0ba64c52c31"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/b74f89fd-fa7c-5a38-a259-c78634fa4685"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/b98c11a7-8779-545a-97d4-12564d2996f0"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/bc0313c8-520c-5ba6-8d9b-ead65f11e748"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/bc9a1840-4bb1-519f-9482-ae4229e83e96"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/bcb2334f-5a4f-5e72-99ec-52a64167edd2"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/bef6c8af-adff-504e-b04a-10e922466b1d"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/bf3bfe1e-be16-596b-bb2e-b79567974b5e"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/c0fa06da-6741-5ad2-9da3-573bf726a56a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/c47653fc-e05d-58f7-9959-0d15944332c0"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/c4b40b2b-424e-5c39-aac9-90377d055031"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/c5b18571-0eaf-52e4-ac77-116620eefbd4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/c7433c5f-e451-5bd1-b97e-1e51683c1d0f"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/c7f7e18f-1b49-539e-8c02-087216f4826f"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/c881ac07-fe19-5914-b832-d8bb73ce4c6a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/cb7634ef-f8d4-5614-8f29-aaf4346e540a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/cc1f391a-8c80-5587-8f4d-076fb8dba1ab"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/cead3c77-7c10-5ba6-96bc-e5970eccf1d4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/cf062c3c-927e-5fe5-98d3-fe01f47d96c4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d1a23804-1d8e-570b-b8a7-7caf10014d26"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d1da0f01-6091-51ac-bc7b-c93e6eea5902"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d3703025-d053-5a0c-9bfb-e5df3f9f4aa3"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d39a901b-67c5-5d0d-b4ed-7d15536296f6"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d46e7a4b-c979-5f93-b3df-1542caac1ade"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d688384f-6a25-51b4-a189-0515d5c9e2b3"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d7158948-a633-50a4-9c3c-db0928df4d25"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d7b26256-be98-50a6-9236-45db4e790788"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d7d0ec21-79fb-5fcc-9e2a-20c92710a3ed"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d88d5d1c-a57f-5f2d-bb58-dae0b1937cb5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d988307b-8d4b-5c1b-b93b-ab10a44fa8a4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/d9df67c3-30a7-5c36-8dbf-1b624cfd6742"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/dad1c8f4-3068-558d-8546-0a5f4dc8ae6c"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/ddda5ad8-21af-5310-82ff-744d43106730"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/de256041-b912-52da-9491-7b471da7a4a5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/e072be28-3d8f-5294-9ef5-78152e1dd9a3"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/e1f594ed-a0a9-5160-8735-49895b3bee7a"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/e201d704-0aca-51e9-ae3c-99d04ed62f31"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/e3563ffa-9101-51d9-9f11-855b7fd885df"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/e45f8981-fa37-5e66-94a7-96fe5b06cee5"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/e668b351-ede1-544a-a961-61ee5b8d7e49"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/e6ef3aec-be63-5919-afa8-1b92e9267b68"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/ebc4ad17-fa7f-534c-8490-8608afcc95b0"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/ecb3598e-45f5-5abe-9160-245dd3dcbcf3"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/ed7cf186-b4ac-52d8-a437-9d6d60a62de2"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/ee2a9677-9c95-57e6-9e72-0f67a58650ca"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/ef08564b-6808-5d7a-8ec0-78cc967bec0c"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/f0c97499-1823-5a57-a2e9-a37dc5da6ab1"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/f3545943-599a-524e-84dd-00be7e9a11a3"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/f4780cf8-2649-559b-880d-955313c154de"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/f5e001b8-1794-59f8-b565-07cd897e4d71"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/f5e4f937-6fda-5391-8c6f-209388a82998"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/f60e4345-d01f-58c0-a5d7-07b5e48a0bdd"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/f6c6c160-0157-5229-bb9b-4a7f9d80f1e4"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/f758462c-740a-50dd-8c6d-7f9570f9dfeb"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/fa7221b4-303f-5a00-8661-6c52e8800e8b"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/fa856de0-0946-5d3f-8f9f-ea005eede469"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/fca74525-2368-540b-86b0-996a66925314"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/fd6fd758-dda1-5435-bce2-9537f3f165ab"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/fe916a38-a706-55d1-a0a1-23bae5de1954"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "kwinrc"."Tiling/ff51ace0-88bb-54af-9479-58ed034df9d9"."tiles" =
          "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5},{\"width\":0.5}]}";
        "kwinrc"."Windows"."ElectricBorderCornerRatio" = 0.2;
        "kwinrc"."Xwayland"."Scale" = 1;
        "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "MNS";
        "kwinrc"."org/kde/kdecoration2"."ButtonsOnLeft" = "MNS";
        "kxkbrc"."Layout"."DisplayNames" = ",,,";
        "kxkbrc"."Layout"."LayoutList" = "gb,fr,be,us";
        "kxkbrc"."Layout"."Model" = "pc86";
        "kxkbrc"."Layout"."ResetOldOptions" = false;
        "kxkbrc"."Layout"."SwitchMode" = "Global";
        "kxkbrc"."Layout"."Use" = true;
        "kxkbrc"."Layout"."VariantList" = ",,,";
        "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
        "plasmanotifyrc"."Applications.thunderbird"."ShowPopupsInDndMode" = true;
        "plasmanotifyrc"."Applications/firefox"."Seen" = true;
        "plasmanotifyrc"."Applications/signal"."Seen" = true;
        "plasmanotifyrc"."Applications/thunderbird"."ShowPopupsInDndMode" = true;
        "plasmanotifyrc"."Notifications"."LowPriorityHistory" = true;
        "plasmanotifyrc"."Notifications"."NormalAlwaysOnTop" = true;
        "plasmaparc"."General"."RaiseMaximumVolume" = true;
        "plasmarc"."PlasmaToolTips"."Delay" = 1;
        "plasmarc"."Theme"."name" = "breeze-dark";
        "plasmarc"."Wallpapers"."usersWallpapers" =
          "/home/pol/Pictures/Backgrounds/Starry Nebula 219.png,/home/pol/Pictures/Backgrounds/nix-snowflake-wallpaper.svg";
        "spectaclerc"."Annotations"."annotationToolType" = 5;
        "spectaclerc"."Annotations"."rectangleFillColor" = "255,255,255,0";
        "spectaclerc"."Annotations"."rectangleShadow" = false;
        "spectaclerc"."Annotations"."rectangleStrokeColor" = "255,0,0";
        "spectaclerc"."Annotations"."rectangleStrokeWidth" = 5;
        "spectaclerc"."Annotations"."textFont" = "Aporetic Sans Mono,22,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
        "spectaclerc"."Annotations"."textFontColor" = "255,0,0";
        "spectaclerc"."GuiConfig"."captureDelay" = 2;
        "spectaclerc"."GuiConfig"."captureMode" = 0;
        "spectaclerc"."ImageSave"."translatedScreenshotsFolder" = "Screenshots";
        "spectaclerc"."VideoSave"."translatedScreencastsFolder" = "Screencasts";
        "systemsettingsrc"."KFileDialog Settings"."detailViewIconSize" = 16;
        "systemsettingsrc"."Notification Messages"."FormatSettingsChanged" = false;
        "systemsettingsrc"."Open-with settings"."CompletionMode" = 1;
        "systemsettingsrc"."Open-with settings"."History" = "";
        "systemsettingsrc"."systemsettings_sidebar_mode"."HighlightNonDefaultSettings" = false;
      };
      dataFile = {
        "dolphin/view_properties/global/.directory"."Dolphin"."HeaderColumnWidths" = "707,79,146";
        "dolphin/view_properties/global/.directory"."Dolphin"."SortOrder" = 1;
        "dolphin/view_properties/global/.directory"."Dolphin"."SortRole" = "modificationtime";
        "kate/anonymous.katesession"."Kate Plugins"."bookmarksplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."cmaketoolsplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."compilerexplorer" = false;
        "kate/anonymous.katesession"."Kate Plugins"."eslintplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."externaltoolsplugin" = true;
        "kate/anonymous.katesession"."Kate Plugins"."formatplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katebacktracebrowserplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katebuildplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katecloseexceptplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katecolorpickerplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katectagsplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katefilebrowserplugin" = true;
        "kate/anonymous.katesession"."Kate Plugins"."katefiletreeplugin" = true;
        "kate/anonymous.katesession"."Kate Plugins"."kategdbplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."kategitblameplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katekonsoleplugin" = true;
        "kate/anonymous.katesession"."Kate Plugins"."kateprojectplugin" = true;
        "kate/anonymous.katesession"."Kate Plugins"."katereplicodeplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katesearchplugin" = true;
        "kate/anonymous.katesession"."Kate Plugins"."katesnippetsplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katesqlplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katesymbolviewerplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katexmlcheckplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."katexmltoolsplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."keyboardmacrosplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."ktexteditorpreviewplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."latexcompletionplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."lspclientplugin" = true;
        "kate/anonymous.katesession"."Kate Plugins"."openlinkplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."rainbowparens" = false;
        "kate/anonymous.katesession"."Kate Plugins"."rbqlplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."tabswitcherplugin" = true;
        "kate/anonymous.katesession"."Kate Plugins"."templateplugin" = false;
        "kate/anonymous.katesession"."Kate Plugins"."textfilterplugin" = true;
        "kate/anonymous.katesession"."MainWindow0"."Active ViewSpace" = 0;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-H-Splitter" = "0,1830,0";
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Bar-0-TvList" =
          "kate_private_plugin_katefiletreeplugin,kateproject,kateprojectgit,kate_private_plugin_katefileselectorplugin";
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-LastSize" = 449;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-SectSizes" = 0;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Splitter" = 1094;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Bar-0-TvList" =
          "lspclient_symbol_outline";
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-LastSize" = 160;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-SectSizes" = 0;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Splitter" = 1094;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Bar-0-TvList" = "";
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-LastSize" = 160;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-SectSizes" = 0;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Splitter" = 1830;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Bar-0-TvList" =
          "output,kate_plugin_katesearch,kateprojectinfo,kate_private_plugin_katekonsoleplugin,diagnostics";
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-LastSize" = 160;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-SectSizes" = 0;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Splitter" = 1574;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Style" = 2;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Visible" = true;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Position" = 3;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Show-Button-In-Sidebar" =
          true;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Visible" = false;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Position" = 3;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Show-Button-In-Sidebar" =
          true;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Visible" =
          false;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefileselectorplugin-Position" =
          0;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefileselectorplugin-Show-Button-In-Sidebar" =
          true;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefileselectorplugin-Visible" =
          false;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Position" =
          0;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Show-Button-In-Sidebar" =
          true;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Visible" =
          false;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Position" =
          3;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Show-Button-In-Sidebar" =
          true;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Visible" =
          false;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Position" = 0;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Show-Button-In-Sidebar" =
          true;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Visible" = false;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Position" = 0;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Show-Button-In-Sidebar" =
          true;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Visible" = false;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Position" = 3;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Show-Button-In-Sidebar" =
          true;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Visible" = false;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Position" =
          1;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Show-Button-In-Sidebar" =
          true;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Visible" =
          false;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Position" = 3;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Show-Button-In-Sidebar" = true;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Visible" = false;
        "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-V-Splitter" = "0,1092,0";
        "kate/anonymous.katesession"."MainWindow0"."ToolBarsMovable" = "Disabled";
        "kate/anonymous.katesession"."MainWindow0 Settings"."ToolBarsMovable" = "Disabled";
        "kate/anonymous.katesession"."MainWindow0 Settings"."WindowState" = 10;
        "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Children" = "MainWindow0-ViewSpace 0";
        "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Orientation" = 1;
        "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Sizes" = 1830;
        "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Active View" =
          "file:///home/pol/Downloads/3. MNIST_Classification_Torch_2024.ipynb";
        "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Count" = 1;
        "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Documents" =
          "file:///home/pol/Downloads/3. MNIST_Classification_Torch_2024.ipynb";
        "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."View 0" =
          "file:///home/pol/Downloads/3. MNIST_Classification_Torch_2024.ipynb";
        "kate/anonymous.katesession"."MainWindow0-ViewSpace 0 0"."CursorColumn" = 0;
        "kate/anonymous.katesession"."MainWindow0-ViewSpace 0 0"."CursorLine" = 604;
        "kate/anonymous.katesession"."Open Documents"."Count" = 1;
        "kate/anonymous.katesession"."Open MainWindows"."Count" = 1;
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."Allow Expansion" = false;
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."Decoration position" = 2;
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."Show Inline Previews" =
          true;
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."Show Preview" = false;
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."Show hidden files" =
          false;
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."Sort by" = "Date";
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."Sort directories first" =
          true;
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."Sort hidden files last" =
          false;
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."Sort reversed" = false;
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."View Style" =
          "DetailTree";
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."auto sync folder" = true;
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."filter history" = "";
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."highlight current file" =
          true;
        "kate/anonymous.katesession"."Plugin:katefilebrowserplugin:MainWindow:0"."url navigator editable" =
          false;
        "kate/anonymous.katesession"."Plugin:kateprojectplugin:"."projects" = "";
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."BinaryFiles" = false;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentExcludeFilter" = "-1";
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentFilter" = "-1";
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExcludeFilters" = "";
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExpandSearchResults" = false;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Filters" = "";
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."FollowSymLink" = false;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."HiddenFiles" = false;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."MatchCase" = false;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Place" = 1;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Recursive" = true;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Replaces" = "";
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Search" = "";
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeAllProjects" =
          true;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeCurrentFile" =
          true;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeFolder" = true;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeOpenFiles" =
          true;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeProject" = true;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchDiskFiles" = "";
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SizeLimit" = 128;
        "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."UseRegExp" = false;
      };
    };
  };
}
