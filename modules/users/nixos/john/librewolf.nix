{ config, pkgs, ... }:
{
  config =
    let
      lepton = pkgs.fetchFromGitHub {
        owner = "black7375";
        repo = "Firefox-UI-Fix";
        rev = "7343efe88d88b2d7cc4434401ab16e2c3799ccbd";
        hash = "sha256-4D880bHhEib3uJDoFP3yz6H6Iipei8yhf+LgUTsyGNQ=";
      };
    in
    {
      home.file.".mozilla/native-messaging-hosts".force = true;
      home.file.".mozilla/firefox/profiles.ini".target = ".librewolf/profiles.ini";
      home.file.".librewolf/john".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.mozilla/firefox/john";
      programs.firefox = {
        enable = true;
        package = pkgs.wrapFirefox pkgs.librewolf-unwrapped {
          inherit (pkgs.librewolf-unwrapped) extraPrefsFiles extraPoliciesFiles;
          wmClass = "librewolf";
          libName = "librewolf";
          nativeMessagingHosts = [
            pkgs.keepassxc
            pkgs.plasma-browser-integration
            pkgs.fx-cast-bridge
          ];
        };
        profiles.john = {
          extensions = (
            with pkgs.firefoxAddons;
            [
              cookies-txt
              dont-accept-webp
              fx_cast
              image-reverse-search
              keepassxc-browser
              libredirect
              load-reddit-images-directly
              localcdn-fork-of-decentraleyes
              nazeka
              old-reddit-redirect
              return-youtube-dislikes
              ruffle_rs
              sponsorblock
              uaswitcher
              unpaywall
              violentmonkey
              youtube-shorts-block
            ]
          );
          settings = {
            # Remember history for now.
            "places.history.enabled" = 1;
            "privacy.sanitize.pending" = "[]";

            # Force use of xdg-desktop-portal.
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            "widget.use-xdg-desktop-portal.location" = 1;
            "widget.use-xdg-desktop-portal.mime-handler" = 1;
            "widget.use-xdg-desktop-portal.open-uri" = 1;
            "widget.use-xdg-desktop-portal.settings" = 1;

            # Disable pasting with middlemouse
            "middlemouse.paste" = false;

            # Use dark theme
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

            # Lepton
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "svg.context-properties.content.enabled" = true;
            "browser.compactmode.show" = true;
            "browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar" = false;
            "layout.css.has-selector.enabled" = true;
            "userChrome.tab.connect_to_window" = true;
            "userChrome.tab.color_like_toolbar" = true;
            "userChrome.tab.lepton_like_padding" = false;
            "userChrome.tab.photon_like_padding" = true;
            "userChrome.tab.dynamic_separator" = false;
            "userChrome.tab.static_separator" = true;
            "userChrome.tab.static_separator.selected_accent" = false;
            "userChrome.tab.bar_separator" = false;
            "userChrome.tab.newtab_button_like_tab" = false;
            "userChrome.tab.newtab_button_smaller" = true;
            "userChrome.tab.newtab_button_proton" = false;
            "userChrome.icon.panel_full" = false;
            "userChrome.icon.panel_photon" = true;
            "userChrome.tab.box_shadow" = false;
            "userChrome.tab.bottom_rounded_corner" = false;
            "userChrome.tab.photon_like_contextline" = true;
            "userChrome.rounding.square_tab" = true;
            "userChrome.compatibility.theme" = true;
            "userChrome.compatibility.os" = true;
            "userChrome.theme.built_in_contrast" = true;
            "userChrome.theme.system_default" = true;
            "userChrome.theme.proton_color" = true;
            "userChrome.theme.proton_chrome" = true;
            "userChrome.theme.fully_color" = true;
            "userChrome.theme.fully_dark" = true;
            "userChrome.decoration.cursor" = true;
            "userChrome.decoration.field_border" = true;
            "userChrome.decoration.download_panel" = true;
            "userChrome.decoration.animate" = true;
            "userChrome.padding.tabbar_width" = true;
            "userChrome.padding.tabbar_height" = true;
            "userChrome.padding.toolbar_button" = true;
            "userChrome.padding.navbar_width" = true;
            "userChrome.padding.urlbar" = true;
            "userChrome.padding.bookmarkbar" = true;
            "userChrome.padding.infobar" = true;
            "userChrome.padding.menu" = true;
            "userChrome.padding.bookmark_menu" = true;
            "userChrome.padding.global_menubar" = true;
            "userChrome.padding.panel" = true;
            "userChrome.padding.popup_panel" = true;
            "userChrome.tab.multi_selected" = true;
            "userChrome.tab.unloaded" = true;
            "userChrome.tab.letters_cleary" = true;
            "userChrome.tab.close_button_at_hover" = true;
            "userChrome.tab.sound_hide_label" = true;
            "userChrome.tab.sound_with_favicons" = true;
            "userChrome.tab.pip" = true;
            "userChrome.tab.container" = true;
            "userChrome.tab.crashed" = true;
            "userChrome.fullscreen.overlap" = true;
            "userChrome.fullscreen.show_bookmarkbar" = true;
            "userChrome.icon.library" = true;
            "userChrome.icon.panel" = true;
            "userChrome.icon.menu" = true;
            "userChrome.icon.context_menu" = true;
            "userChrome.icon.global_menu" = true;
            "userChrome.icon.global_menubar" = true;
            "userChrome.icon.1-25px_stroke" = true;
            "userContent.player.ui" = true;
            "userContent.player.icon" = true;
            "userContent.player.noaudio" = true;
            "userContent.player.size" = true;
            "userContent.player.click_to_play" = true;
            "userContent.player.animate" = true;
            "userContent.newTab.full_icon" = true;
            "userContent.newTab.animate" = true;
            "userContent.newTab.pocket_to_last" = true;
            "userContent.newTab.searchbar" = true;
            "userContent.page.field_border" = true;
            "userContent.page.illustration" = true;
            "userContent.page.proton_color" = true;
            "userContent.page.dark_mode" = true;
            "userContent.page.proton" = true;
            "browser.tabs.cardPreview.enabled" = true;
            "browser.urlbar.clipboard.featureGate" = true;
            "browser.urlbar.suggest.calculator" = true;
          };
          userChrome = ''
            @import url("file://${lepton}/css/leptonChrome.css");
          '';
          userContent = ''
            @import url("file://${lepton}/css/leptonContent.css");
          '';
        };
      };
    };
}
