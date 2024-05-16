{ pkgs, ... }:
{
  config = {
    environment.etc."xdg/kitty/kitty.conf".source = ./kitty.conf;
    environment.systemPackages = with pkgs; [ kitty ];

    nixpkgs.overlays = [
      (final: prev: {
        kitty = prev.kitty.overrideAttrs (prevAttrs: {
          patches = (prevAttrs.patches or [ ]) ++ [
            (pkgs.fetchpatch {
              name = "fcitx-workaround.diff";
              url = "https://github.com/kovidgoyal/kitty/commit/aecf07bcbaa74507526d3f700954842176fef4f2.diff";
              hash = "sha256-6m4D/xX5dx0v6rhzIyTlkQyCRb2Ik2Ek3q0BrL3saTw=";
            })
          ];
        });
      })
    ];
  };
}
