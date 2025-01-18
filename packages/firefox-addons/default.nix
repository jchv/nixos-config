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
