{ lib, ... }:
{
  config = {
    environment.etc."gtk-3.0/settings.ini".text = lib.mkAfter ''
      [Settings]
      gtk-decoration-layout = menu:none
      gtk-enable-primary-paste = false
      gtk-overlay-scrolling = false
    '';
    environment.etc."gtk-4.0/settings.ini".text = lib.mkAfter ''
      [Settings]
      gtk-decoration-layout = menu:none
      gtk-enable-primary-paste = false
    '';
  };
}
