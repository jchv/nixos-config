(
  final: prev:
  let
    inherit (prev) lib;
    inherit (final) callPackage;
  in
  {
    firefoxAddons = lib.recurseIntoAttrs (callPackage ./firefox-addons { inherit (final) nur; });
    mediaplayer = callPackage ./mediaplayer.nix { };
    age-plugin-fido2-hmac = callPackage ./age-plugin-fido2-hmac.nix { };
  }
)
