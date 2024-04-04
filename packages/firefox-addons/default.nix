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
