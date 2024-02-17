{ config, pkgs, lib, ... }: {
  config = {
    home.file.".mozilla/firefox/profiles.ini".target = ".librewolf/profiles.ini";
    home.file.".librewolf/john".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.mozilla/firefox/john";
    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.librewolf-unwrapped {
        inherit (pkgs.librewolf-unwrapped) extraPrefsFiles extraPoliciesFiles;
        wmClass = "librewolf";
        libName = "librewolf";
        nativeMessagingHosts = with pkgs; [ keepassxc ];
      };
      profiles.john = {
        extensions = (with pkgs.firefoxAddons; [
          cookies-txt
          dont-accept-webp
          image-reverse-search
          keepassxc-browser
          libredirect
          load-reddit-images-directly
          localcdn-fork-of-decentraleyes
          nazeka
          old-reddit-redirect
          return-youtube-dislikes
          sponsorblock
          uaswitcher
          unpaywall
          violentmonkey
          youtube-shorts-block
        ]);
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
        };
      };
    };
  };
}
