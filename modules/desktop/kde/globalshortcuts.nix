{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.jchw.desktop.kde;
  format = pkgs.formats.ini { };
  shortcutsFile = format.generate "kglobalshortcutsrc" cfg.globalShortcuts;
in
{
  options = {
    jchw.desktop.kde = {
      globalShortcuts = lib.mkOption {
        description = "Global shortcuts to be placed in kglobalshortcutsrc.";
        type = (pkgs.formats.ini { }).type;
      };
    };
  };

  config = lib.mkIf config.jchw.desktop.kde.enable {
    jchw.desktop.kde.globalShortcuts = {
      "ActivityManager" = {
        "_k_friendly_name" = "Activity Manager";
        "switch-to-activity-a7e2f79f-ded2-4496-b1ba-74991febcde7" = ''none,none,Switch to activity "Default"'';
      };
      "KDE Keyboard Layout Switcher" = {
        "Switch keyboard layout to English (US)" = "none,none,Switch keyboard layout to English (US)";
        "Switch to Last-Used Keyboard Layout" = "Meta+Alt+L,Meta+Alt+L,Switch to Last-Used Keyboard Layout";
        "Switch to Next Keyboard Layout" = "Meta+Alt+K,Meta+Alt+K,Switch to Next Keyboard Layout";
        "_k_friendly_name" = "Keyboard Layout Switcher";
      };
      "kaccess" = {
        "Toggle Screen Reader On and Off" = "Meta+Alt+S,Meta+Alt+S,Toggle Screen Reader On and Off";
        "_k_friendly_name" = "Accessibility";
      };
      "kcm_touchpad" = {
        "Disable Touchpad" = "Touchpad Off,Touchpad Off,";
        "Enable Touchpad" = "Touchpad On,Touchpad On,";
        "Toggle Touchpad" = "Touchpad Toggle\\tMeta+Ctrl+Zenkaku Hankaku,Touchpad Toggle\\tMeta+Ctrl+Zenkaku Hankaku,";
        "_k_friendly_name" = "Touchpad";
      };
      "kmix" = {
        "_k_friendly_name" = "Audio Volume";
        "decrease_microphone_volume" = "Microphone Volume Down,Microphone Volume Down,Decrease Microphone Volume";
        "decrease_volume" = "Volume Down,Volume Down,Decrease Volume";
        "decrease_volume_small" = "Shift+Volume Down,Shift+Volume Down,Decrease Volume by 1%";
        "increase_microphone_volume" = "Microphone Volume Up,Microphone Volume Up,Increase Microphone Volume";
        "increase_volume" = "Volume Up,Volume Up,Increase Volume";
        "increase_volume_small" = "Shift+Volume Up,Shift+Volume Up,Increase Volume by 1%";
        "mic_mute" = "Microphone Mute\\tMeta+Volume Mute,Microphone Mute\\tMeta+Volume Mute,Mute Microphone";
        "mute" = "Volume Mute,Volume Mute,Mute";
      };
      "ksmserver" = {
        "Halt Without Confirmation" = "none,,Shut Down Without Confirmation";
        "Lock Session" = "Meta+L\\tScreensaver,Meta+L\\tScreensaver,Lock Session";
        "Log Out" = "Ctrl+Alt+Del,Ctrl+Alt+Del,Show Logout Prompt";
        "Log Out Without Confirmation" = "none,,Log Out Without Confirmation";
        "LogOut" = "none,,Log Out";
        "Reboot" = "none,,Reboot";
        "Reboot Without Confirmation" = "none,,Reboot Without Confirmation";
        "Shut Down" = "none,,Shut Down";
        "_k_friendly_name" = "Session Management";
      };
      "kwin" = {
        "Activate Window Demanding Attention" = "Meta+Ctrl+A,Meta+Ctrl+A,Activate Window Demanding Attention";
        "Cube" = "Meta+C,Meta+C,Toggle Cube";
        "Cycle Overview" = "none,none,Cycle through Overview and Grid View";
        "Cycle Overview Opposite" = "none,none,Cycle through Grid View and Overview";
        "Decrease Opacity" = "none,,Decrease Opacity of Active Window by 5%";
        "Edit Tiles" = "Meta+T,Meta+T,Toggle Tiles Editor";
        "Expose" = "Ctrl+F9,Ctrl+F9,Toggle Present Windows (Current desktop)";
        "ExposeAll" = "Ctrl+F10\\tLaunch (C),Ctrl+F10\\tLaunch (C),Toggle Present Windows (All desktops)";
        "ExposeClass" = "Ctrl+F7,Ctrl+F7,Toggle Present Windows (Window class)";
        "ExposeClassCurrentDesktop" = "none,none,Toggle Present Windows (Window class on current desktop)";
        "Grid View" = "Meta+G,Meta+G,Toggle Grid View";
        "Increase Opacity" = "none,,Increase Opacity of Active Window by 5%";
        "Kill Window" = "Meta+Ctrl+Esc,Meta+Ctrl+Esc,Kill Window";
        "Move Tablet to Next Output" = "none,none,Move the tablet to the next output";
        "MoveMouseToCenter" = "Meta+F6,Meta+F6,Move Mouse to Center";
        "MoveMouseToFocus" = "Meta+F5,Meta+F5,Move Mouse to Focus";
        "MoveZoomDown" = "none,none,Move Zoomed Area Downwards";
        "MoveZoomLeft" = "none,none,Move Zoomed Area to Left";
        "MoveZoomRight" = "none,none,Move Zoomed Area to Right";
        "MoveZoomUp" = "none,none,Move Zoomed Area Upwards";
        "Overview" = "Meta+W,Meta+W,Toggle Overview";
        "Setup Window Shortcut" = "none,,Setup Window Shortcut";
        "Show Desktop" = "Meta+D,Meta+D,Peek at Desktop";
        "Switch One Desktop Down" = "Meta+Ctrl+Down,Meta+Ctrl+Down,Switch One Desktop Down";
        "Switch One Desktop Up" = "Meta+Ctrl+Up,Meta+Ctrl+Up,Switch One Desktop Up";
        "Switch One Desktop to the Left" = "Meta+Ctrl+Left,Meta+Ctrl+Left,Switch One Desktop to the Left";
        "Switch One Desktop to the Right" = "Meta+Ctrl+Right,Meta+Ctrl+Right,Switch One Desktop to the Right";
        "Switch Window Down" = "Meta+Alt+Down,Meta+Alt+Down,Switch to Window Below";
        "Switch Window Left" = "Meta+Alt+Left,Meta+Alt+Left,Switch to Window to the Left";
        "Switch Window Right" = "Meta+Alt+Right,Meta+Alt+Right,Switch to Window to the Right";
        "Switch Window Up" = "Meta+Alt+Up,Meta+Alt+Up,Switch to Window Above";
        "Switch to Desktop 1" = "Meta+1,Ctrl+F1,Switch to Desktop 1";
        "Switch to Desktop 10" = "none,,Switch to Desktop 10";
        "Switch to Desktop 11" = "none,,Switch to Desktop 11";
        "Switch to Desktop 12" = "none,,Switch to Desktop 12";
        "Switch to Desktop 13" = "none,,Switch to Desktop 13";
        "Switch to Desktop 14" = "none,,Switch to Desktop 14";
        "Switch to Desktop 15" = "none,,Switch to Desktop 15";
        "Switch to Desktop 16" = "none,,Switch to Desktop 16";
        "Switch to Desktop 17" = "none,,Switch to Desktop 17";
        "Switch to Desktop 18" = "none,,Switch to Desktop 18";
        "Switch to Desktop 19" = "none,,Switch to Desktop 19";
        "Switch to Desktop 2" = "Meta+2,Ctrl+F2,Switch to Desktop 2";
        "Switch to Desktop 20" = "none,,Switch to Desktop 20";
        "Switch to Desktop 3" = "Meta+3,Ctrl+F3,Switch to Desktop 3";
        "Switch to Desktop 4" = "Meta+4,Ctrl+F4,Switch to Desktop 4";
        "Switch to Desktop 5" = "Meta+5,,Switch to Desktop 5";
        "Switch to Desktop 6" = "Meta+6,,Switch to Desktop 6";
        "Switch to Desktop 7" = "Meta+7,,Switch to Desktop 7";
        "Switch to Desktop 8" = "Meta+8,,Switch to Desktop 8";
        "Switch to Desktop 9" = "Meta+9,,Switch to Desktop 9";
        "Switch to Next Desktop" = "none,,Switch to Next Desktop";
        "Switch to Next Screen" = "none,,Switch to Next Screen";
        "Switch to Previous Desktop" = "none,,Switch to Previous Desktop";
        "Switch to Previous Screen" = "none,,Switch to Previous Screen";
        "Switch to Screen 0" = "none,,Switch to Screen 0";
        "Switch to Screen 1" = "none,,Switch to Screen 1";
        "Switch to Screen 2" = "none,,Switch to Screen 2";
        "Switch to Screen 3" = "none,,Switch to Screen 3";
        "Switch to Screen 4" = "none,,Switch to Screen 4";
        "Switch to Screen 5" = "none,,Switch to Screen 5";
        "Switch to Screen 6" = "none,,Switch to Screen 6";
        "Switch to Screen 7" = "none,,Switch to Screen 7";
        "Switch to Screen Above" = "none,,Switch to Screen Above";
        "Switch to Screen Below" = "none,,Switch to Screen Below";
        "Switch to Screen to the Left" = "none,,Switch to Screen to the Left";
        "Switch to Screen to the Right" = "none,,Switch to Screen to the Right";
        "Toggle Night Color" = "none,none,Suspend/Resume Night Light";
        "Toggle Window Raise/Lower" = "none,,Toggle Window Raise/Lower";
        "Walk Through Windows" = "Alt+Tab,Alt+Tab,Walk Through Windows";
        "Walk Through Windows (Reverse)" = "Alt+Shift+Tab,Alt+Shift+Tab,Walk Through Windows (Reverse)";
        "Walk Through Windows Alternative" = "none,,Walk Through Windows Alternative";
        "Walk Through Windows Alternative (Reverse)" = "none,,Walk Through Windows Alternative (Reverse)";
        "Walk Through Windows of Current Application" = "Alt+`,Alt+`,Walk Through Windows of Current Application";
        "Walk Through Windows of Current Application (Reverse)" = "Alt+~,Alt+~,Walk Through Windows of Current Application (Reverse)";
        "Walk Through Windows of Current Application Alternative" = "none,,Walk Through Windows of Current Application Alternative";
        "Walk Through Windows of Current Application Alternative (Reverse)" = "none,,Walk Through Windows of Current Application Alternative (Reverse)";
        "Window Above Other Windows" = "none,,Keep Window Above Others";
        "Window Below Other Windows" = "none,,Keep Window Below Others";
        "Window Close" = "Alt+F4,Alt+F4,Close Window";
        "Window Fullscreen" = "none,,Make Window Fullscreen";
        "Window Grow Horizontal" = "none,,Expand Window Horizontally";
        "Window Grow Vertical" = "none,,Expand Window Vertically";
        "Window Lower" = "none,,Lower Window";
        "Window Maximize" = "Meta+PgUp,Meta+PgUp,Maximize Window";
        "Window Maximize Horizontal" = "none,,Maximize Window Horizontally";
        "Window Maximize Vertical" = "none,,Maximize Window Vertically";
        "Window Minimize" = "Meta+PgDown,Meta+PgDown,Minimize Window";
        "Window Move" = "none,,Move Window";
        "Window Move Center" = "none,,Move Window to the Center";
        "Window No Border" = "none,,Toggle Window Titlebar and Frame";
        "Window On All Desktops" = "none,,Keep Window on All Desktops";
        "Window One Desktop Down" = "Meta+Ctrl+Shift+Down,Meta+Ctrl+Shift+Down,Window One Desktop Down";
        "Window One Desktop Up" = "Meta+Ctrl+Shift+Up,Meta+Ctrl+Shift+Up,Window One Desktop Up";
        "Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left,Meta+Ctrl+Shift+Left,Window One Desktop to the Left";
        "Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right,Meta+Ctrl+Shift+Right,Window One Desktop to the Right";
        "Window One Screen Down" = "none,,Move Window One Screen Down";
        "Window One Screen Up" = "none,,Move Window One Screen Up";
        "Window One Screen to the Left" = "none,,Move Window One Screen to the Left";
        "Window One Screen to the Right" = "none,,Move Window One Screen to the Right";
        "Window Operations Menu" = "Alt+F3,Alt+F3,Window Operations Menu";
        "Window Pack Down" = "none,,Move Window Down";
        "Window Pack Left" = "none,,Move Window Left";
        "Window Pack Right" = "none,,Move Window Right";
        "Window Pack Up" = "none,,Move Window Up";
        "Window Quick Tile Bottom" = "Meta+Down,Meta+Down,Quick Tile Window to the Bottom";
        "Window Quick Tile Bottom Left" = "none,,Quick Tile Window to the Bottom Left";
        "Window Quick Tile Bottom Right" = "none,,Quick Tile Window to the Bottom Right";
        "Window Quick Tile Left" = "Meta+Left,Meta+Left,Quick Tile Window to the Left";
        "Window Quick Tile Right" = "Meta+Right,Meta+Right,Quick Tile Window to the Right";
        "Window Quick Tile Top" = "Meta+Up,Meta+Up,Quick Tile Window to the Top";
        "Window Quick Tile Top Left" = "none,,Quick Tile Window to the Top Left";
        "Window Quick Tile Top Right" = "none,,Quick Tile Window to the Top Right";
        "Window Raise" = "none,,Raise Window";
        "Window Resize" = "none,,Resize Window";
        "Window Shade" = "none,,Shade Window";
        "Window Shrink Horizontal" = "none,,Shrink Window Horizontally";
        "Window Shrink Vertical" = "none,,Shrink Window Vertically";
        "Window to Desktop 1" = "Meta+!,,Window to Desktop 1";
        "Window to Desktop 10" = "none,,Window to Desktop 10";
        "Window to Desktop 11" = "none,,Window to Desktop 11";
        "Window to Desktop 12" = "none,,Window to Desktop 12";
        "Window to Desktop 13" = "none,,Window to Desktop 13";
        "Window to Desktop 14" = "none,,Window to Desktop 14";
        "Window to Desktop 15" = "none,,Window to Desktop 15";
        "Window to Desktop 16" = "none,,Window to Desktop 16";
        "Window to Desktop 17" = "none,,Window to Desktop 17";
        "Window to Desktop 18" = "none,,Window to Desktop 18";
        "Window to Desktop 19" = "none,,Window to Desktop 19";
        "Window to Desktop 2" = "Meta+@,,Window to Desktop 2";
        "Window to Desktop 20" = "none,,Window to Desktop 20";
        "Window to Desktop 3" = "Meta+#,,Window to Desktop 3";
        "Window to Desktop 4" = "Meta+$,,Window to Desktop 4";
        "Window to Desktop 5" = "Meta+%,,Window to Desktop 5";
        "Window to Desktop 6" = "Meta+^,,Window to Desktop 6";
        "Window to Desktop 7" = "Meta+&,,Window to Desktop 7";
        "Window to Desktop 8" = "Meta+*,,Window to Desktop 8";
        "Window to Desktop 9" = "Meta+(,,Window to Desktop 9";
        "Window to Next Desktop" = "none,,Window to Next Desktop";
        "Window to Next Screen" = "Meta+Shift+Right,Meta+Shift+Right,Move Window to Next Screen";
        "Window to Previous Desktop" = "none,,Window to Previous Desktop";
        "Window to Previous Screen" = "Meta+Shift+Left,Meta+Shift+Left,Move Window to Previous Screen";
        "Window to Screen 0" = "none,,Move Window to Screen 0";
        "Window to Screen 1" = "none,,Move Window to Screen 1";
        "Window to Screen 2" = "none,,Move Window to Screen 2";
        "Window to Screen 3" = "none,,Move Window to Screen 3";
        "Window to Screen 4" = "none,,Move Window to Screen 4";
        "Window to Screen 5" = "none,,Move Window to Screen 5";
        "Window to Screen 6" = "none,,Move Window to Screen 6";
        "Window to Screen 7" = "none,,Move Window to Screen 7";
        "_k_friendly_name" = "KWin";
        "view_actual_size" = "Meta+0,Meta+0,Zoom to Actual Size";
        "view_zoom_in" = "Meta++\\tMeta+=,Meta++\\tMeta+=,Zoom In";
        "view_zoom_out" = "Meta+-,Meta+-,Zoom Out";
      };
      "mediacontrol" = {
        "_k_friendly_name" = "Media Controller";
        "mediavolumedown" = "none,,Media volume down";
        "mediavolumeup" = "none,,Media volume up";
        "nextmedia" = "Media Next,Media Next,Media playback next";
        "pausemedia" = "Media Pause,Media Pause,Pause media playback";
        "playmedia" = "none,,Play media playback";
        "playpausemedia" = "Media Play,Media Play,Play/Pause media playback";
        "previousmedia" = "Media Previous,Media Previous,Media playback previous";
        "stopmedia" = "Media Stop,Media Stop,Stop media playback";
      };
      "org_kde_powerdevil" = {
        "Decrease Keyboard Brightness" = "Keyboard Brightness Down,Keyboard Brightness Down,Decrease Keyboard Brightness";
        "Decrease Screen Brightness" = "Monitor Brightness Down,Monitor Brightness Down,Decrease Screen Brightness";
        "Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down,Shift+Monitor Brightness Down,Decrease Screen Brightness by 1%";
        "Hibernate" = "Hibernate,Hibernate,Hibernate";
        "Increase Keyboard Brightness" = "Keyboard Brightness Up,Keyboard Brightness Up,Increase Keyboard Brightness";
        "Increase Screen Brightness" = "Monitor Brightness Up,Monitor Brightness Up,Increase Screen Brightness";
        "Increase Screen Brightness Small" = "Shift+Monitor Brightness Up,Shift+Monitor Brightness Up,Increase Screen Brightness by 1%";
        "PowerDown" = "Power Down,Power Down,Power Down";
        "PowerOff" = "Power Off,Power Off,Power Off";
        "Sleep" = "Sleep,Sleep,Suspend";
        "Toggle Keyboard Backlight" = "Keyboard Light On/Off,Keyboard Light On/Off,Toggle Keyboard Backlight";
        "Turn Off Screen" = "none,none,Turn Off Screen";
        "_k_friendly_name" = "KDE Power Management System";
        "powerProfile" = "Battery\\tMeta+B,Battery\\tMeta+B,Switch Power Profile";
      };
      "plasmashell" = {
        "_k_friendly_name" = "plasmashell";
        "activate application launcher" = "Meta\\tAlt+F1,Meta\\tAlt+F1,Activate Application Launcher";
        "activate task manager entry 1" = "none,Meta+1,Activate Task Manager Entry 1";
        "activate task manager entry 10" = "none,Meta+0,Activate Task Manager Entry 10";
        "activate task manager entry 2" = "none,Meta+2,Activate Task Manager Entry 2";
        "activate task manager entry 3" = "none,Meta+3,Activate Task Manager Entry 3";
        "activate task manager entry 4" = "none,Meta+4,Activate Task Manager Entry 4";
        "activate task manager entry 5" = "none,Meta+5,Activate Task Manager Entry 5";
        "activate task manager entry 6" = "none,Meta+6,Activate Task Manager Entry 6";
        "activate task manager entry 7" = "none,Meta+7,Activate Task Manager Entry 7";
        "activate task manager entry 8" = "none,Meta+8,Activate Task Manager Entry 8";
        "activate task manager entry 9" = "none,Meta+9,Activate Task Manager Entry 9";
        "clear-history" = "none,,Clear Clipboard History";
        "clipboard_action" = "Meta+Ctrl+X,Meta+Ctrl+X,Automatic Action Popup Menu";
        "cycle-panels" = "Meta+Alt+P,Meta+Alt+P,Move keyboard focus between panels";
        "cycleNextAction" = "none,,Next History Item";
        "cyclePrevAction" = "none,,Previous History Item";
        "manage activities" = "Meta+Q,Meta+Q,Show Activity Switcher";
        "next activity" = "Meta+A,none,Walk through activities";
        "previous activity" = "Meta+Shift+A,none,Walk through activities (Reverse)";
        "repeat_action" = "none,Meta+Ctrl+R,Manually Invoke Action on Current Clipboard";
        "show dashboard" = "Ctrl+F12,Ctrl+F12,Show Desktop";
        "show-barcode" = "none,,Show Barcode…";
        "show-on-mouse-pos" = "Meta+V,Meta+V,Show Clipboard Items at Mouse Position";
        "stop current activity" = "Meta+S,Meta+S,Stop Current Activity";
        "switch to next activity" = "none,,Switch to Next Activity";
        "switch to previous activity" = "none,,Switch to Previous Activity";
        "toggle do not disturb" = "none,,Toggle do not disturb";
      };
    };

    home-manager.sharedModules = [
      (
        { config, ... }:
        {
          config = {
            home.file."${config.xdg.configHome}/kglobalshortcutsrc" = {
              source = shortcutsFile;
            };
          };
        }
      )
    ];
  };
}
