(
  nur: final: prev:
  let
    inherit (prev) pkgs lib;
    inherit (final) callPackage;
  in
  {
    firefoxAddons = lib.recurseIntoAttrs (callPackage ./firefox-addons { inherit nur; });
    mediaplayer = callPackage ./mediaplayer.nix { };
    age-plugin-fido2-hmac = callPackage ./age-plugin-fido2-hmac.nix { };
  }
)
