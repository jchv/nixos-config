{ config, pkgs, lib, ... }: {
  imports =
    [
      ./dbus.nix
      ./display.nix
      ./fonts.nix
      ./ime.nix
      ./input.nix
      ./keyring.nix
      ./overrides.nix
      ./portal.nix
      ./qt.nix
      ./waybar.nix
    ];

  config = {
    programs.sway = {
      enable = true;
      extraOptions = [
        "--verbose"
        "--debug"
        "--unsupported-gpu"
      ];
      extraSessionCommands = lib.mkBefore ''
        # Ensure that the environment is set properly.
        . /etc/set-environment

        export XDG_CURRENT_DESKTOP="sway"
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';

      extraPackages = with pkgs; [
        swaybg
        swayidle
        xwayland
        waybar
        wofi
        libappindicator-gtk3
        grim
        sway-contrib.grimshot
        slurp
        swaynotificationcenter
        wl-clipboard
      ];
    };

    services = {
      udev.packages = with pkgs; [
        libwacom
        libinput.out
        pkgs.libmtp.out
      ];
      udisks2.enable = true;
      devmon.enable = true;
      blueman.enable = true;

      gvfs = {
        enable = true;
        package = pkgs.gnome.gvfs;
      };

      xserver = {
        enable = true;
        displayManager = {
          defaultSession = "sway";
          gdm.enable = true;
        };
        upscaleDefaultCursor = false;
      };

      gnome = {
        gnome-keyring = {
          enable = true;
        };
      };
    };

    nixpkgs.overlays = [
      (self: super: {
        sway-unwrapped = super.sway-unwrapped.overrideAttrs (final: prev: {
          patches = (prev.patches or []) ++ [
            (pkgs.fetchpatch {
              url = "https://patch-diff.githubusercontent.com/raw/swaywm/sway/pull/7039.diff";
              hash = "sha256-nR9QIJ+669UtEOth2YRELKHq7M4a79WX6M3GKF5Uuc0=";
            })
          ];
        });
      })
    ];

    environment = {
      sessionVariables = {
        LD_LIBRARY_PATH = [ "${pkgs.libappindicator-gtk3.out}/lib" ];
        NIXOS_OZONE_WL = "1";
      };

      etc."udisks2/mount_options.conf".text = ''
        [defaults]
        ntfs_defaults=uid=$UID,gid=$GID,prealloc
      '';

      etc."sway/config".text = ''
        set $mod Mod4
        set $swayidle ${pkgs.swayidle.out}/bin/swayidle
        set $swaylock ${pkgs.swaylock.out}/bin/swaylock
        set $swaymsg ${pkgs.sway.out}/bin/swaymsg
        set $swaynag ${pkgs.sway.out}/bin/swaynag
        set $systemctl ${pkgs.systemd.out}/bin/systemctl
        set $dolphin ${pkgs.dolphin.out}/bin/dolphin
        set $dex ${pkgs.dex.out}/bin/dex

        titlebar_border_thickness 1
        titlebar_padding 5

        # DBus graphical environment
        # XDG Autostart
        exec --no-startup-id $dex -a

        # Display keys
        set $brightnessctl ${pkgs.brightnessctl.out}/bin/brightnessctl
        bindsym --locked XF86MonBrightnessDown exec $brightnessctl set 5%-
        bindsym --locked XF86MonBrightnessUp exec $brightnessctl set +5%

        # Audio keys
        set $pulsemixer ${pkgs.pulsemixer.out}/bin/pulsemixer
        bindsym --locked XF86AudioRaiseVolume exec $pulsemixer --change-volume +5
        bindsym --locked XF86AudioLowerVolume exec $pulsemixer --change-volume -5
        bindsym --locked XF86AudioMute exec $pulsemixer --toggle-mute

        # Music keys
        set $playerctl ${pkgs.playerctl.out}/bin/playerctl
        bindsym XF86AudioPlay exec $playerctl --player=playerctld play-pause
        bindsym XF86AudioPause exec $playerctl --player=playerctld play-pause
        bindsym --locked XF86AudioPlay exec $playerctl --player=playerctld pause
        bindsym --locked XF86AudioPause exec $playerctl --player=playerctld pause
        bindsym --locked XF86AudioPrev exec $playerctl --player=playerctld previous
        bindsym --locked XF86AudioNext exec $playerctl --player=playerctld next

        # Screenshot keys
        set $grimshot ${pkgs.sway-contrib.grimshot.out}/bin/grimshot
        bindsym --release Print exec $grimshot --notify copy area
        bindsym --release $mod+Print exec $grimshot --notify copy active
        bindsym --release $mod+p exec $grimshot --notify copy area
        bindsym --release Shift+$mod+p exec $grimshot --notify copy active
        for_window [title=".*"] title_format "%app_id %instance :: %shell"

        # Idle timeout
        exec $swayidle -w \
            timeout 750 '$swaylock -f -c 000000' \
            timeout 800 '$swaymsg "output * dpms off"' \
            resume '$swaymsg "output * dpms on"' \
            before-sleep '$swaylock -f -c 000000'

        for_window [title="^Dolphin$"] inhibit_idle visible

        # Playerctl, for better playback control.
        # Should be OK to rerun it a lot.
        # It will just crash if it's already running in this session.
        exec_always ${pkgs.playerctl.out}/bin/playerctld

        # Notifications
        exec --no-startup-id ${pkgs.swaynotificationcenter.out}/bin/swaync
        bindsym $mod+Shift+n exec ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw

        # Polkit (auth) daemon
        exec --no-startup-id ${pkgs.lxde.lxsession.out}/bin/lxpolkit

        bindsym $mod+Return exec ${pkgs.kitty.out}/bin/kitty
        bindsym $mod+Shift+q kill
        bindsym $mod+d exec ${pkgs.zsh.out}/bin/zsh -c "${pkgs.fuzzel.out}/bin/fuzzel --width 80"
        bindsym $mod+Home exec $dolphin --new-window $HOME
        floating_modifier $mod normal
        bindsym $mod+Shift+c reload
        bindsym $mod+Shift+e exec $swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' '$swaymsg exit'
        bindsym $mod+i exec systemd-inhibit --mode=block --what=sleep:handle-lid-switch $swaynag -t warning -e bottom -m "Inhibiting suspend."
        bindsym --locked $mod+Shift+s exec sleep 1 && $systemctl suspend
        bindsym $mod+l exec $swaylock -f -c 000000
        bindsym $mod+Left focus left
        bindsym $mod+Down focus down
        bindsym $mod+Up focus up
        bindsym $mod+Right focus right
        bindsym $mod+Shift+Left move left
        bindsym $mod+Shift+Down move down
        bindsym $mod+Shift+Up move up
        bindsym $mod+Shift+Right move right
        bindsym $mod+1 workspace 1
        bindsym $mod+2 workspace 2
        bindsym $mod+3 workspace 3
        bindsym $mod+4 workspace 4
        bindsym $mod+5 workspace 5
        bindsym $mod+6 workspace 6
        bindsym $mod+7 workspace 7
        bindsym $mod+8 workspace 8
        bindsym $mod+9 workspace 9
        bindsym $mod+0 workspace 10
        bindsym $mod+Shift+1 move container to workspace 1
        bindsym $mod+Shift+2 move container to workspace 2
        bindsym $mod+Shift+3 move container to workspace 3
        bindsym $mod+Shift+4 move container to workspace 4
        bindsym $mod+Shift+5 move container to workspace 5
        bindsym $mod+Shift+6 move container to workspace 6
        bindsym $mod+Shift+7 move container to workspace 7
        bindsym $mod+Shift+8 move container to workspace 8
        bindsym $mod+Shift+9 move container to workspace 9
        bindsym $mod+Shift+0 move container to workspace 10
        bindsym $mod+b splith
        bindsym $mod+v splitv
        bindsym $mod+s sticky toggle
        bindsym $mod+w layout tabbed
        bindsym $mod+e layout toggle split
        bindsym $mod+f fullscreen
        bindsym $mod+Shift+space floating toggle
        bindsym $mod+space focus mode_toggle
        bindsym $mod+a focus parent
        bindsym $mod+Shift+minus move scratchpad
        bindsym $mod+minus scratchpad show
        mode "resize" {
            bindsym Left resize shrink width 10px
            bindsym Down resize grow height 10px
            bindsym Up resize shrink height 10px
            bindsym Right resize grow width 10px
            bindsym Return mode "default"
            bindsym Escape mode "default"
        }
        bindsym $mod+r mode "resize"

        mode "pause passthrough" {
            bindsym $mod+Pause mode "default"
        }
        bindsym $mod+Pause mode "pause passthrough"

        mode "menu passthrough" {
            bindsym $mod+Menu mode "default"
        }
        bindsym $mod+Menu mode "menu passthrough"
      '';
    };
  };
}
