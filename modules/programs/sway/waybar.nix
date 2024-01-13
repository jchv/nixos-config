{ pkgs, ... }: {
  config =
  let
    mediaplayer = pkgs.callPackage ../../../packages/mediaplayer.nix {};
  in {
    environment.etc = {
      "sway/config".text = ''
        bar {
            swaybar_command ${pkgs.waybar.out}/bin/waybar
        }
      '';
      "xdg/waybar/config".text = ''
        {
          "height": 30, // Waybar height (to be removed for auto height)
          "spacing": 4, // Gaps between modules (4px)
          "modules-left": ["sway/workspaces", "sway/mode", "sway/scratchpad", "custom/media"],
          "modules-center": ["sway/window"],
          "modules-right": ["idle_inhibitor", "pulseaudio", "network", "cpu", "memory", "temperature", "backlight", "keyboard-state", "upower", "clock", "tray"],
          "keyboard-state": {
            "numlock": true,
            "capslock": true,
            "format": "{name} {icon}",
            "format-icons": {
              "locked": "",
              "unlocked": ""
            }
          },
          "sway/mode": {
            "format": "<span style=\"italic\">{}</span>"
          },
          "sway/scratchpad": {
            "format": "{icon} {count}",
            "show-empty": false,
            "format-icons": ["", ""],
            "tooltip": true,
            "tooltip-format": "{app}: {title}"
          },
          "mpd": {
            "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
            "format-disconnected": "Disconnected ",
            "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
            "unknown-tag": "N/A",
            "interval": 2,
            "consume-icons": {
              "on": " "
            },
            "random-icons": {
              "off": "<span color=\"#f53c3c\"></span> ",
              "on": " "
            },
            "repeat-icons": {
              "on": " "
            },
            "single-icons": {
              "on": "1 "
            },
            "state-icons": {
              "paused": "",
              "playing": ""
            },
            "tooltip-format": "MPD (connected)",
            "tooltip-format-disconnected": "MPD (disconnected)"
          },
          "idle_inhibitor": {
            "format": "{icon}",
            "format-icons": {
              "activated": "",
              "deactivated": ""
            }
          },
          "tray": {
            "spacing": 10
          },
          "clock": {
            "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
            "format-alt": "{:%Y-%m-%d}"
          },
          "cpu": {
            "format": "{usage}% ",
            "tooltip": false
          },
          "memory": {
            "format": "{}% "
          },
          "temperature": {
            "critical-threshold": 80,
            "format": "{temperatureC}°C {icon}",
            "format-icons": ["", "", ""]
          },
          "backlight": {
            "format": "{percent}% {icon}",
            "format-icons": ["", "", "", "", "", "", "", "", ""]
          },
          "upower": {
            "icon-size": 12,
            "hide-if-empty": true,
            "tooltip": true,
            "tooltip-spacing": 20,
            "format": " {percentage}",
            "format-alt": " {percentage}"
          },
          "network": {
            "format-wifi": "{essid} ({signalStrength}%) ",
            "format-ethernet": "{ipaddr}/{cidr} ",
            "tooltip-format": "{ifname} via {gwaddr} ",
            "format-linked": "{ifname} (No IP) ",
            "format-disconnected": "Disconnected ⚠",
            "format-alt": "{ifname}: {ipaddr}/{cidr}"
          },
          "pulseaudio": {
            // "scroll-step": 1, // %, can be a float
            "format": "{volume}% {icon} {format_source}",
            "format-bluetooth": "{volume}% {icon} {format_source}",
            "format-bluetooth-muted": " {icon} {format_source}",
            "format-muted": " {format_source}",
            "format-source": "{volume}% ",
            "format-source-muted": "",
            "format-icons": {
              "headphone": "",
              "hands-free": "",
              "headset": "",
              "phone": "",
              "portable": "",
              "car": "",
              "default": ["", "", ""]
            },
            "on-click": "pavucontrol"
          },
          "custom/media": {
            "format": "{icon} {}",
            "return-type": "json",
            "max-length": 40,
            "format-icons": {
              "spotify": "",
              "default": "🎜"
            },
            "escape": true,
            "exec": "${mediaplayer} 2> /dev/null", // Filter player based on name
            "on-click": "${pkgs.playerctl.out}/bin/playerctl --player=playerctld play-pause"
          }
        }
      '';
    };
  };
}
