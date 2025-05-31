{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "cookies-txt" = buildFirefoxXpiAddon {
      pname = "cookies-txt";
      version = "0.8";
      addonId = "{12cf650b-1822-40aa-bff0-996df6948878}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4451023/cookies_txt-0.8.xpi";
      sha256 = "0cfa85e4f1defc0f0e72c4b7a26372d7890d52780e555b868ef4a3759d7bc3ec";
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
      version = "4.3.1";
      addonId = "{0da2e603-21ba-4422-8049-b6d9e013ed84}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4343711/image_reverse_search-4.3.1.xpi";
      sha256 = "23ee693e6ff075fd665dc51befe6a994eb4a5793fc275bb08532a5108e455921";
      meta = with lib;
      {
        homepage = "https://github.com/Brawl345/Image-Reverse-Search-with-Google";
        description = "Adds an option to the context menu to search with an image on Google, Bing, Yandex, TinEye, SauceNAO, IQDB or custom search engines. You can also choose more than one and they will be shown in a submenu!";
        mozPermissions = [ "contextMenus" "storage" ];
        platforms = platforms.all;
      };
    };
    "keepassxc-browser" = buildFirefoxXpiAddon {
      pname = "keepassxc-browser";
      version = "1.9.8";
      addonId = "keepassxc-browser@keepassxc.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/4477789/keepassxc_browser-1.9.8.xpi";
      sha256 = "7629ee8fe6a8bace5d0f12c3aef41803c2ab01407a22ad8803633992a6c4eda2";
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
    "libredirect" = buildFirefoxXpiAddon {
      pname = "libredirect";
      version = "3.1.0";
      addonId = "7esoorv3@alefvanoon.anonaddy.me";
      url = "https://addons.mozilla.org/firefox/downloads/file/4429228/libredirect-3.1.0.xpi";
      sha256 = "d86a48e0ce416f59cebea52c4152d822a86ec304588785bfb14cb27c3f494775";
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
      version = "1.8";
      addonId = "{4c421bb7-c1de-4dc6-80c7-ce8625e34d24}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4329559/load_reddit_images_directly-1.8.xpi";
      sha256 = "da4485950ffaace68c2e45862702b18204dd05fe28f5d7ed3c3525094d6d9b97";
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
          "*://www.reddit.com/*"
          "*://www.reddit.com/r/*"
        ];
        platforms = platforms.all;
      };
    };
    "localcdn-fork-of-decentraleyes" = buildFirefoxXpiAddon {
      pname = "localcdn-fork-of-decentraleyes";
      version = "2.6.79";
      addonId = "{b86e4813-687a-43e6-ab65-0bde4ab75758}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4464649/localcdn_fork_of_decentraleyes-2.6.79.xpi";
      sha256 = "3180fe626b674d63191cc6d26516b16fd82f3e23500457e6149dcd14febd9eb5";
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
      version = "2.0.5";
      addonId = "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4472856/old_reddit_redirect-2.0.5.xpi";
      sha256 = "8b67dfe22d2a7dedddc362a0fb14f90176d7afdc7386e17131a17c831eecf3ed";
      meta = with lib;
      {
        homepage = "https://github.com/tom-james-watson/old-reddit-redirect";
        description = "Ensure Reddit always loads the old design";
        license = licenses.mit;
        mozPermissions = [
          "declarativeNetRequestWithHostAccess"
          "https://old.reddit.com/*"
        ];
        platforms = platforms.all;
      };
    };
    "return-youtube-dislikes" = buildFirefoxXpiAddon {
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
    "ruffle_rs" = buildFirefoxXpiAddon {
      pname = "ruffle_rs";
      version = "0.1.0.1580";
      addonId = "{b5501fd1-7084-45c5-9aa6-567c2fcf5dc6}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4497149/ruffle_rs-0.1.0.1580.xpi";
      sha256 = "9131ce4826a204c562ed625a5f96172ab0554583d722d0d97f5787652013850b";
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
      version = "5.12.4";
      addonId = "sponsorBlocker@ajay.app";
      url = "https://addons.mozilla.org/firefox/downloads/file/4501802/sponsorblock-5.12.4.xpi";
      sha256 = "789c63e5cfc74aa11661459de7ab87c0143cca5a0944aab700a6044497bf40eb";
      meta = with lib;
      {
        homepage = "https://sponsor.ajay.app";
        description = "Easily skip YouTube video sponsors. When you visit a YouTube video, the extension will check the database for reported sponsors and automatically skip known sponsors. You can also report sponsors in videos. Other browsers: https://sponsor.ajay.app";
        license = licenses.lgpl3;
        mozPermissions = [
          "storage"
          "scripting"
          "https://sponsor.ajay.app/*"
          "https://*.youtube.com/*"
          "https://www.youtube-nocookie.com/embed/*"
        ];
        platforms = platforms.all;
      };
    };
    "uaswitcher" = buildFirefoxXpiAddon {
      pname = "uaswitcher";
      version = "1.4.89";
      addonId = "user-agent-switcher@ninetailed.ninja";
      url = "https://addons.mozilla.org/firefox/downloads/file/4449854/uaswitcher-1.4.89.xpi";
      sha256 = "ad488274976139ce84517a3e12de6b729edfb8daded18c7184ffc64b90591a0a";
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
      version = "2.31.0";
      addonId = "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4455138/violentmonkey-2.31.0.xpi";
      sha256 = "8880114a3ac30a5f3aebc71443f86a1f7fdd1ec9298def22dc2e250502ecccee";
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