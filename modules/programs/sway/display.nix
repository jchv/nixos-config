{ ... }: {
  config = {
    environment.etc."sway/config".text = ''
      # Display configuration
      output eDP-1 scale 1.5 bg ${../../../wallpapers/th.jpg} fill
      output DP-1 bg ${../../../wallpapers/c1.jpg} fill
      output DP-2 bg ${../../../wallpapers/c2.jpg} fill
      output DSI-1 transform 90
    '';
  };
}
