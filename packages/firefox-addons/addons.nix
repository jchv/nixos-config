{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "cookies-txt" = buildFirefoxXpiAddon {
      pname = "cookies-txt";
      version = "0.6";
      addonId = "{12cf650b-1822-40aa-bff0-996df6948878}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4203553/cookies_txt-0.6.xpi";
      sha256 = "62344e9fc9c24f8dad1fd2ee48b7b90fe818db4216c9e950c5070886593b28ad";
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
        ];
        platforms = platforms.all;
      };
    };
    "dont-accept-webp" = buildFirefoxXpiAddon {
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
    "image-reverse-search" = buildFirefoxXpiAddon {
      pname = "image-reverse-search";
      version = "3.4.4";
      addonId = "{0da2e603-21ba-4422-8049-b6d9e013ed84}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4074017/image_reverse_search-3.4.4.xpi";
      sha256 = "22c1e735f03d37d64a611bbd6d14b1cb3295a0ce0d91c5eaca3b9ec4a78254a1";
      meta = with lib;
      {
        homepage = "https://github.com/Brawl345/Image-Reverse-Search-with-Google";
        description = "Adds an option to the context menu to search with an image on Google, Bing, Yandex, TinEye, SauceNAO, IQDB or custom search engines. You can also choose more than one and they will be shown in a submenu!";
        license = licenses.mpl20;
        mozPermissions = [ "contextMenus" "storage" ];
        platforms = platforms.all;
      };
    };
    "keepassxc-browser" = buildFirefoxXpiAddon {
      pname = "keepassxc-browser";
      version = "1.8.12";
      addonId = "keepassxc-browser@keepassxc.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4228043/keepassxc_browser-1.8.12.xpi";
      sha256 = "c5c5c2def2040f32dde6d59e4e98515682eefc52bd8679128b5627e71c84cdc9";
      meta = with lib;
      {
        homepage = "https://keepassxc.org/";
        description = "Official browser plugin for the KeePassXC password manager (<a rel=\"nofollow\" href=\"https://prod.outgoing.prod.webservices.mozgcp.net/v1/aebde84f385b73661158862b419dd43b46ac4c22bea71d8f812030e93d0e52d5/https%3A//keepassxc.org\">https://keepassxc.org</a>).";
        license = licenses.gpl3;
        mozPermissions = [
          "activeTab"
          "contextMenus"
          "cookies"
          "clipboardWrite"
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
    "libredirect" = buildFirefoxXpiAddon {
      pname = "libredirect";
      version = "2.8.1";
      addonId = "7esoorv3@alefvanoon.anonaddy.me";
      url = "https://addons.mozilla.org/firefox/downloads/file/4178347/libredirect-2.8.1.xpi";
      sha256 = "c91f19377b07b119eec4d53c28c45cdb5d0755287a79b715328654adb5c7ddfa";
      meta = with lib;
      {
        homepage = "https://libredirect.github.io";
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
    "load-reddit-images-directly" = buildFirefoxXpiAddon {
      pname = "load-reddit-images-directly";
      version = "1.3";
      addonId = "{4c421bb7-c1de-4dc6-80c7-ce8625e34d24}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4219481/load_reddit_images_directly-1.3.xpi";
      sha256 = "fdfaca60cefdd34cc66747308cbaf26279a241df7d5f3aa5cd6b4cd350cecaa8";
      meta = with lib;
      {
        description = "Firefox web extension that loads reddit images directly instead of redirecting to the HTML page containing the image. This works for <a href=\"https://prod.outgoing.prod.webservices.mozgcp.net/v1/81e40807248441ca24f789047ae28a7a8266f8ad344ea6f4977e4473d60d20e5/http%3A//i.redd.it\" rel=\"nofollow\">i.redd.it</a>, <a href=\"https://prod.outgoing.prod.webservices.mozgcp.net/v1/8e73e8b6575335896f295209eb7b291999654798ffcb596097c6a3cafd045683/http%3A//preview.redd.it\" rel=\"nofollow\">preview.redd.it</a>, <a href=\"https://prod.outgoing.prod.webservices.mozgcp.net/v1/7e63b0cb427894e946e7065c2badea35dadb397a6a87745849d72f65a9cad794/http%3A//external-preview.redd.it\" rel=\"nofollow\">external-preview.redd.it</a> and <a href=\"https://prod.outgoing.prod.webservices.mozgcp.net/v1/5b712eb108fa1803f12422942e6674a8d67e9e8b02d20ccfcce6cf2cb33c934d/http%3A//www.reddit.com/media\" rel=\"nofollow\">www.reddit.com/media</a> urls.";
        license = licenses.mpl20;
        mozPermissions = [
          "webRequest"
          "webRequestBlocking"
          "*://i.redd.it/*"
          "*://external-preview.redd.it/*"
          "*://preview.redd.it/*"
          "*://www.reddit.com/media*"
        ];
        platforms = platforms.all;
      };
    };
    "localcdn-fork-of-decentraleyes" = buildFirefoxXpiAddon {
      pname = "localcdn-fork-of-decentraleyes";
      version = "2.6.63";
      addonId = "{b86e4813-687a-43e6-ab65-0bde4ab75758}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4231487/localcdn_fork_of_decentraleyes-2.6.63.xpi";
      sha256 = "6989dc192f992b809ddb99c8454677a9e7a2d8f0fe14d080369d1bf6bc0c5cf6";
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
    "nazeka" = buildFirefoxXpiAddon {
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
    "old-reddit-redirect" = buildFirefoxXpiAddon {
      pname = "old-reddit-redirect";
      version = "1.8.1";
      addonId = "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4182157/old_reddit_redirect-1.8.1.xpi";
      sha256 = "bd411715bb36bd535a0211a47bd69c73abefac6153164f7e00f5b57971397700";
      meta = with lib;
      {
        homepage = "https://github.com/tom-james-watson/old-reddit-redirect";
        description = "Ensure Reddit always loads the old design";
        license = licenses.mit;
        mozPermissions = [
          "webRequest"
          "webRequestBlocking"
          "*://reddit.com/*"
          "*://www.reddit.com/*"
          "*://np.reddit.com/*"
          "*://amp.reddit.com/*"
          "*://i.reddit.com/*"
          "*://i.redd.it/*"
          "*://preview.redd.it/*"
          "*://old.reddit.com/*"
        ];
        platforms = platforms.all;
      };
    };
    "return-youtube-dislikes" = buildFirefoxXpiAddon {
      pname = "return-youtube-dislikes";
      version = "3.0.0.14";
      addonId = "{762f9885-5a13-4abd-9c77-433dcd38b8fd}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4208483/return_youtube_dislikes-3.0.0.14.xpi";
      sha256 = "a31ab23549846b7eab92a094e92df8349047b48bbd807f069d128083c3b27f61";
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
    "search-by-image" = buildFirefoxXpiAddon {
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
    "sponsorblock" = buildFirefoxXpiAddon {
      pname = "sponsorblock";
      version = "5.5.4";
      addonId = "sponsorBlocker@ajay.app";
      url = "https://addons.mozilla.org/firefox/downloads/file/4229442/sponsorblock-5.5.4.xpi";
      sha256 = "5ffbbbfb0090eb44be36e0f569cd9b5654f3d58e97e6190430f11cfb1ca8e39f";
      meta = with lib;
      {
        homepage = "https://sponsor.ajay.app";
        description = "Easily skip YouTube video sponsors. When you visit a YouTube video, the extension will check the database for reported sponsors and automatically skip known sponsors. You can also report sponsors in videos. Other browsers: https://sponsor.ajay.app";
        license = licenses.lgpl3;
        mozPermissions = [
          "storage"
          "https://sponsor.ajay.app/*"
          "scripting"
          "https://*.youtube.com/*"
          "https://www.youtube-nocookie.com/embed/*"
        ];
        platforms = platforms.all;
      };
    };
    "uaswitcher" = buildFirefoxXpiAddon {
      pname = "uaswitcher";
      version = "1.4.47";
      addonId = "user-agent-switcher@ninetailed.ninja";
      url = "https://addons.mozilla.org/firefox/downloads/file/4234218/uaswitcher-1.4.47.xpi";
      sha256 = "11f7538d3bf08f2ad340626acaa1a8d1455852d4a9d36acb82257ca3ef17e209";
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
    "unpaywall" = buildFirefoxXpiAddon {
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
    "violentmonkey" = buildFirefoxXpiAddon {
      pname = "violentmonkey";
      version = "2.18.0";
      addonId = "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4220396/violentmonkey-2.18.0.xpi";
      sha256 = "4abbeea842b82965379c6011dec6a435dfff0f69c20749118a8ba2f7d14cb0f1";
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
    "youtube-shorts-block" = buildFirefoxXpiAddon {
      pname = "youtube-shorts-block";
      version = "1.4.1";
      addonId = "{34daeb50-c2d2-4f14-886a-7160b24d66a4}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4121795/youtube_shorts_block-1.4.1.xpi";
      sha256 = "57102a854845371b6a161b505f4372fb967e40d7e9aea9bee5e2cce798d2535a";
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