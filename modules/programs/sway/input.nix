{
  config = {
    environment.etc."sway/config".text = ''
      # Input configuration
      input "1149:32792:Kensington_Expert_Wireless_TB_Mouse" {
          accel_profile adaptive
          pointer_accel 1
          scroll_factor 1
      }

      input "1118:2479:Microsoft_Surface_045E:09AF_Touchpad" {
          click_method clickfinger
      }

      input "2362:628:PIXA3854:00_093A:0274_Touchpad" {
          click_method clickfinger
      }

      input "1539:4104:SINO_WEALTH______________________________________Mouse" {
          scroll_button button2
          scroll_method on_button_down
      }

      primary_selection disabled
    '';
  };
}
