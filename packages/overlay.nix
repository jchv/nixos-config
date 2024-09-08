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
    kdePackages = prev.kdePackages.overrideScope (
      gfinal: gprev: {
        kio-extras = gprev.kio-extras.overrideAttrs {
          src = pkgs.fetchurl {
            url = "https://invent.kde.org/network/kio-extras/-/archive/0200554c98dd745f81d0b060872880bb3fb113a6/kio-extras-0200554c98dd745f81d0b060872880bb3fb113a6.tar.gz";
            hash = "sha256-ZYYZrv6NEAXo+SQZlzs+uzG9GTXdf+ISw2AbBSf32Bk=";
          };
        };
      }
    );
  }
)
