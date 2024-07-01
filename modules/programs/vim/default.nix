{ pkgs, ... }:
{
  config = {
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    } // import ./config.nix;

    environment.systemPackages = [ pkgs.nixfmt-rfc-style ];
  };
}
