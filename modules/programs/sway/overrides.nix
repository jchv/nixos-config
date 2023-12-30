{ lib, ... }: {
  config = {
    environment.etc."sway/config".text = lib.mkAfter ''
      # For development, force lightspark to floating.
      for_window [class="lightspark"] floating enable

      # Vice breaks when not floating.
      for_window [instance="x64sc"] floating enable

      # Ghidra tooltips.
      for_window [class="^Ghidra$" title="^win\d*$"] floating enable, move position mouse

      # Firefox Picture-in-picture
      for_window [title="^Picture-in-Picture$"] floating enable, sticky enable

      # Dolphin progress windows
      for_window [app_id="org.kde.dolphin" title="Progress Dialog — Dolphin"] floating enable
      for_window [app_id="org.kde.dolphin" title="Copying — Dolphin"] floating enable
      for_window [app_id="org.kde.dolphin" title="Moving — Dolphin"] floating enable
      for_window [app_id="org.kde.dolphin" title="Deleting — Dolphin"] floating enable
      for_window [app_id="org.kde.dolphin" title="^Copying \(.+ of .+\) — Dolphin"] floating enable
      for_window [app_id="org.kde.dolphin" title="^Moving \(.+ of .+\) — Dolphin"] floating enable
      for_window [app_id="org.kde.dolphin" title="^Deleting \(.+ of .+\) — Dolphin"] floating enable

      # Wine virtual desktop
      for_window [title="- Wine desktop$" instance="explorer.exe" class="Wine"] floating enable

      # Wine Wayland... (Better to start floating and switch later I think.)
      for_window [app_id=".*\.exe$"] floating enable

      # Dolphin emulator should inhibit idle
      for_window [title="^Dolphin$"] inhibit_idle visible
    '';
  };
}
