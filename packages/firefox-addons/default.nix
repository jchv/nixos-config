{
  lib,
  stdenv,
  fetchurl,
  nur,
  ...
}:
import ./addons.nix {
  inherit lib stdenv fetchurl;
  inherit (nur.repos.rycee.firefox-addons) buildFirefoxXpiAddon;
}
// {
  image-reverse-search = stdenv.mkDerivation {
    name = "image-reverse-search-4.3.1";
    addonId = "{0da2e603-21ba-4422-8049-b6d9e013ed84}";
    src = ./extensions/image-reverse-search.xpi;
    preferLocalBuild = true;
    allowSubstitutes = true;
    buildCommand = ''
      dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
      mkdir -p "$dst"
      install -v -m644 "$src" "$dst/0da2e603-21ba-4422-8049-b6d9e013ed84.xpi"
    '';
    meta = {
      homepage = "https://github.com/Brawl345/Image-Reverse-Search-with-Google";
      description = "Adds an option to the context menu to search with an image on Google, Bing, Yandex, TinEye, SauceNAO, IQDB or custom search engines. You can also choose more than one and they will be shown in a submenu!";
      mozPermissions = [
        "contextMenus"
        "storage"
      ];
      platforms = lib.platforms.all;
    };
  };
  fx_cast =
    let
      pname = "fx_cast";
      version = "0.3.1";
    in
    nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon {
      inherit pname version;
      addonId = "fx_cast@matt.tf";
      url = "https://github.com/hensm/fx_cast/releases/download/v${version}/${pname}-${version}.xpi";
      sha256 = "sha256-zaYnUJpJkRAPSCpM3S20PjMS4aeBtQGhXB2wgdlFkSQ=";
      meta = { };
    };
}
