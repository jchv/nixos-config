(nur: self: super:
  let
    inherit (super) pkgs lib;
    inherit (self) callPackage;
  in {
    firefoxAddons = lib.recurseIntoAttrs (callPackage ./firefox-addons { inherit nur; });
    mediaplayer = callPackage ./mediaplayer.nix {};
  }
)
