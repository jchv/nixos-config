{ pkgs, ... }:
{
  config = {
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    } // import ./config.nix;

    environment.systemPackages = with pkgs; [ nixfmt-rfc-style ];

    # Temporary until NixOS/nixpkgs#299970 is merged.
    nixpkgs.overlays = [
      (final: prev: {
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (python-final: python-prev: {
            pynvim-pp = python-prev.pynvim-pp.overrideAttrs {
              version = "unstable-2024-03-11";
              src = final.fetchFromGitHub {
                owner = "ms-jpq";
                repo = "pynvim_pp";
                rev = "34e3a027c595981886d7efd1c91071f3eaa4715d";
                hash = "sha256-2+jDRJXlg9q4MN9vOhmeq4cWVJ0wp5r5xAh3G8lqgOg=";
              };
            };
          })
        ];
      })
    ];
  };
}
