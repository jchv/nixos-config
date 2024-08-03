{ pkgs, ... }:
{
  config = {
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    } // import ./config.nix;

    nixpkgs.overlays = [
      (final: prev: {
        python312 = prev.python312.override {
          packageOverrides = finalPkgs: prevPkgs: {
            pynvim-pp = prevPkgs.pynvim-pp.overrideAttrs {
              version = "unstable-2024-07-31";
              src = final.fetchFromGitHub {
                owner = "ms-jpq";
                repo = "pynvim_pp";
                rev = "6d3c298b7eb9543bce7ab515b0a39f256c1d37ca";
                hash = "sha256-W6YaxI/fa2HL6+FIBTTA+7K2Be02iuIfFFVO/hhYnpo=";
              };
            };
          };
        };
        python312Package = final.python312.pkgs;
      })
    ];

    environment.systemPackages = [ pkgs.nixfmt-rfc-style ];
  };
}
