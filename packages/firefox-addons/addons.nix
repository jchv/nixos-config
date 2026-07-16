{ buildMozillaXpiAddon, fetchurl, lib, stdenv }:
  {
    "cookies-txt" = buildMozillaXpiAddon {
      pname = "cookies-txt";
      version = "1.0";
      addonId = "{12cf650b-1822-40aa-bff0-996df6948878}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4624727/cookies_txt-1.0.xpi";
      sha256 = "5277a747488f2bbe657e83f8266eb7f7d3c30aeb886be53b9de87766f2053406";
      meta = with lib;
      {
        description = "Exports all cookies to a Netscape HTTP Cookie File, as used by curl, wget, and youtube-dl, among others.";
        license = licenses.gpl3;
        mozPermissions = [
          "cookies"
          "downloads"
          "contextualIdentities"
          "<all_urls>"
          "tabs"
          "clipboardWrite"
        ];
        platforms = platforms.all;
      };
    };
    "dont-accept-webp" = buildMozillaXpiAddon {
      pname = "dont-accept-webp";
      version = "0.9";
      addonId = "dont-accept-webp@jeffersonscher.com";
      url = "https://addons.mozilla.org/firefox/downloads/file/4191562/dont_accept_webp-0.9.xpi";
      sha256 = "9d5177cfde905232efde79aa5b617b1a3430f896988f7034a8cd954e64d24ad6";
      meta = with lib;
      {
        homepage = "https://github.com/jscher2000/dont-accept-webp";
        description = "This extension removes image/webp and/or image/avif from the list of formats Firefox tells sites that it accepts. That discourages many servers from replacing JPEG and PNG images with WebP/AVIF. (But some may send them anyway; they aren't blocked.)";
        license = licenses.mpl20;
        mozPermissions = [
          "<all_urls>"
          "activeTab"
          "webRequest"
          "webRequestBlocking"
          "storage"
          "management"
        ];
        platforms = platforms.all;
      };
    };
    "keepassxc-browser" = buildMozillaXpiAddon {
      pname = "keepassxc-browser";
      version = "1.10.3";
      addonId = "keepassxc-browser@keepassxc.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4831838/keepassxc_browser-1.10.3.xpi";
      sha256 = "4df9c54e0a293aa2e37e9bcf97ec307a35a00e78cebaa9a68edba552c07c4568";
      meta = with lib;
      {
        homepage = "https://keepassxc.org/";
        description = "Official browser plugin for the KeePassXC password manager (https://keepassxc.org).";
        license = licenses.gpl3;
        mozPermissions = [
          "activeTab"
          "clipboardWrite"
          "contextMenus"
          "cookies"
          "nativeMessaging"
          "notifications"
          "storage"
          "tabs"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
          "https://*/*"
          "http://*/*"
          "https://api.github.com/"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
    "libredirect" = buildMozillaXpiAddon {
      pname = "libredirect";
      version = "3.3.0";
      addonId = "7esoorv3@alefvanoon.anonaddy.me";
      url = "https://addons.mozilla.org/firefox/downloads/file/4734268/libredirect-3.3.0.xpi";
      sha256 = "1c91739ae52c6eb8522f0efb38397c3d5e85d961b3999f3c5d60f89db447877d";
      meta = with lib;
      {
        homepage = "https://libredirect.manerakai.com/";
        description = "Redirects YouTube, Twitter, TikTok... requests to alternative privacy friendly frontends.";
        license = licenses.gpl3;
        mozPermissions = [
          "webRequest"
          "webRequestBlocking"
          "storage"
          "clipboardWrite"
          "contextMenus"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
    "load-reddit-images-directly" = buildMozillaXpiAddon {
      pname = "load-reddit-images-directly";
      version = "1.9";
      addonId = "{4c421bb7-c1de-4dc6-80c7-ce8625e34d24}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4769138/load_reddit_images_directly-1.9.xpi";
      sha256 = "7242551ae0ce95a09111256caecb492db2e36f4cff3721d8cb7f7bf3369bd819";
      meta = with lib;
      {
        homepage = "https://github.com/nopperl/load-reddit-images-directly";
        description = "Loads reddit images directly instead of redirecting to the HTML page containing the image. This works for i.redd.it, preview.redd.it, external-preview.redd.it and www.reddit.com/media urls.";
        license = licenses.mpl20;
        mozPermissions = [
          "activeTab"
          "storage"
          "webRequest"
          "webRequestBlocking"
          "*://i.redd.it/*"
          "*://external-preview.redd.it/*"
          "*://preview.redd.it/*"
          "*://cf.preview.redd.it/*"
          "*://www.reddit.com/*"
          "*://www.reddit.com/r/*"
        ];
        platforms = platforms.all;
      };
    };
    "localcdn-fork-of-decentraleyes" = buildMozillaXpiAddon {
      pname = "localcdn-fork-of-decentraleyes";
      version = "2.6.85";
      addonId = "{b86e4813-687a-43e6-ab65-0bde4ab75758}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4838011/localcdn_fork_of_decentraleyes-2.6.85.xpi";
      sha256 = "628fcad19950ca5a3005e3e9b54de73842cf9bf87a5c3b543452b10c1647fa60";
      meta = with lib;
      {
        homepage = "https://www.localcdn.org";
        description = "Emulates remote frameworks (e.g. jQuery, Bootstrap, AngularJS) and delivers them as local resource. Prevents unnecessary 3rd party requests to Google, StackPath, MaxCDN and more. Prepared rules for uBlock Origin/uMatrix.";
        license = licenses.mpl20;
        mozPermissions = [
          "*://*/*"
          "privacy"
          "storage"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
        ];
        platforms = platforms.all;
      };
    };
    "nazeka" = buildMozillaXpiAddon {
      pname = "nazeka";
      version = "0.4.10";
      addonId = "nazeka@wareya.moe";
      url = "https://addons.mozilla.org/firefox/downloads/file/3781976/nazeka-0.4.10.xpi";
      sha256 = "4079afe4f8339d4187910a523e190b81a60649bc34a834a5fcac5d3d0697d088";
      meta = with lib;
      {
        homepage = "https://github.com/wareya/nazeka";
        description = "A rikai replacement with very fast text scrubbing. Built-in clipboard grabber.";
        mozPermissions = [
          "contextMenus"
          "storage"
          "tabs"
          "clipboardRead"
          "unlimitedStorage"
          "<all_urls>"
          "http://*/*"
          "https://*/*"
          "ftp://*/*"
          "file:///*"
        ];
        platforms = platforms.all;
      };
    };
    "old-reddit-redirect" = buildMozillaXpiAddon {
      pname = "old-reddit-redirect";
      version = "2.2.0";
      addonId = "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4882083/old_reddit_redirect-2.2.0.xpi";
      sha256 = "5b346ff8f7de84304a402432638efdbdac0a6174d62ac5c2845cce4998f33022";
      meta = with lib;
      {
        homepage = "https://github.com/tom-james-watson/old-reddit-redirect";
        description = "Ensure Reddit always loads the old design";
        license = licenses.mit;
        mozPermissions = [
          "declarativeNetRequestWithHostAccess"
          "https://old.reddit.com/*"
          "https://www.reddit.com/*"
        ];
        platforms = platforms.all;
      };
    };
    "return-youtube-dislikes" = buildMozillaXpiAddon {
      pname = "return-youtube-dislikes";
      version = "3.0.0.18";
      addonId = "{762f9885-5a13-4abd-9c77-433dcd38b8fd}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4371820/return_youtube_dislikes-3.0.0.18.xpi";
      sha256 = "2d33977ce93276537543161f8e05c3612f71556840ae1eb98239284b8f8ba19e";
      meta = with lib;
      {
        description = "Returns ability to see dislike statistics on youtube";
        license = licenses.gpl3;
        mozPermissions = [
          "activeTab"
          "*://*.youtube.com/*"
          "storage"
          "*://returnyoutubedislikeapi.com/*"
        ];
        platforms = platforms.all;
      };
    };
    "ruffle_rs" = buildMozillaXpiAddon {
      pname = "ruffle_rs";
      version = "0.3.0.26163";
      addonId = "{b5501fd1-7084-45c5-9aa6-567c2fcf5dc6}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4847266/ruffle_rs-0.3.0.26163.xpi";
      sha256 = "06de9770e3a14f219a971c70520f9f346027e6ca8141ef93ff02237b395ba62c";
      meta = with lib;
      {
        homepage = "https://ruffle.rs/";
        description = "Putting Flash back on the web.\n\nDesigned to be easy to use, this extension will seamlessly enable you to play flash content, with no extra configuration required!";
        license = licenses.mit;
        mozPermissions = [
          "storage"
          "scripting"
          "declarativeNetRequestWithHostAccess"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
    "search-by-image" = buildMozillaXpiAddon {
      pname = "search-by-image";
      version = "1.3";
      addonId = "{ea1c656c-504f-4b5a-8d2d-8793a9b30605}";
      url = "https://addons.mozilla.org/firefox/downloads/file/3786018/search_by_image-1.3.xpi";
      sha256 = "cd700e00ac4e19b60ff7bf4829538082b3a3a68aff0ade6a9f1ec3cdcb3c33d2";
      meta = with lib;
      {
        description = "Search goods by image in any shops world wide";
        license = licenses.mpl20;
        mozPermissions = [ "contextMenus" "storage" "<all_urls>" ];
        platforms = platforms.all;
      };
    };
    "sponsorblock" = buildMozillaXpiAddon {
      pname = "sponsorblock";
      version = "6.1.7";
      addonId = "sponsorBlocker@ajay.app";
      url = "https://addons.mozilla.org/firefox/downloads/file/4897574/sponsorblock-6.1.7.xpi";
      sha256 = "0d50e1632c6f15ee15a543e670e1c572974605a5c02622916e08e026803df83f";
      meta = with lib;
      {
        homepage = "https://sponsor.ajay.app";
        description = "Easily skip YouTube video sponsors. When you visit a YouTube video, the extension will check the database for reported sponsors and automatically skip known sponsors. You can also report sponsors in videos. Other browsers: https://sponsor.ajay.app";
        license = licenses.lgpl3;
        mozPermissions = [
          "storage"
          "scripting"
          "unlimitedStorage"
          "https://sponsor.ajay.app/*"
          "https://*.youtube.com/*"
          "https://www.youtube-nocookie.com/embed/*"
        ];
        platforms = platforms.all;
      };
    };
    "uaswitcher" = buildMozillaXpiAddon {
      pname = "uaswitcher";
      version = "1.4.102";
      addonId = "user-agent-switcher@ninetailed.ninja";
      url = "https://addons.mozilla.org/firefox/downloads/file/4772478/uaswitcher-1.4.102.xpi";
      sha256 = "b83c36fe95d44ecd5dd8611b4af87390aa7b8c653d637b3bb287c152e63da8c8";
      meta = with lib;
      {
        homepage = "https://gitlab.com/ntninja/user-agent-switcher";
        description = "Easily override the browser's User-Agent string";
        license = licenses.gpl3;
        mozPermissions = [
          "storage"
          "tabs"
          "webNavigation"
          "webRequest"
          "webRequestBlocking"
          "<all_urls>"
        ];
        platforms = platforms.all;
      };
    };
    "unpaywall" = buildMozillaXpiAddon {
      pname = "unpaywall";
      version = "3.98";
      addonId = "{f209234a-76f0-4735-9920-eb62507a54cd}";
      url = "https://addons.mozilla.org/firefox/downloads/file/3816853/unpaywall-3.98.xpi";
      sha256 = "6893bea86d3c4ed7f1100bf0e173591b526a062f4ddd7be13c30a54573c797fb";
      meta = with lib;
      {
        homepage = "https://unpaywall.org/products/extension";
        description = "Get free text of research papers as you browse, using Unpaywall's index of ten million legal, open-access articles.";
        license = licenses.mit;
        mozPermissions = [ "*://*.oadoi.org/*" "storage" "<all_urls>" ];
        platforms = platforms.all;
      };
    };
    "violentmonkey" = buildMozillaXpiAddon {
      pname = "violentmonkey";
      version = "2.41.0";
      addonId = "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4830363/violentmonkey-2.41.0.xpi";
      sha256 = "42d184788bd2f6a291956dd31cd45daa7b4a5d1b19bf1c74fb0ae76e456fa36b";
      meta = with lib;
      {
        homepage = "https://violentmonkey.github.io/";
        description = "Userscript support for browsers, open source.";
        license = licenses.mit;
        mozPermissions = [
          "tabs"
          "<all_urls>"
          "webRequest"
          "webRequestBlocking"
          "notifications"
          "storage"
          "unlimitedStorage"
          "clipboardWrite"
          "contextMenus"
          "cookies"
        ];
        platforms = platforms.all;
      };
    };
    "youtube-shorts-block" = buildMozillaXpiAddon {
      pname = "youtube-shorts-block";
      version = "1.5.3";
      addonId = "{34daeb50-c2d2-4f14-886a-7160b24d66a4}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4487339/youtube_shorts_block-1.5.3.xpi";
      sha256 = "774896393bc782db2d79992a337d782963766365723c4bbab73d53a63feb2043";
      meta = with lib;
      {
        description = "Play the Youtube shorts video as if it were a normal video.\nand hide \"shorts\"tab and videos (optional).";
        license = licenses.mit;
        mozPermissions = [
          "storage"
          "*://*.youtube.com/*"
          "*://m.youtube.com/*"
        ];
        platforms = platforms.all;
      };
    };
  }