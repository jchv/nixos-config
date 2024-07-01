{ pkgs, ... }:
{
  config = {
    environment.etc."xdg/kitty/kitty.conf".source = ./kitty.conf;
    environment.systemPackages = [ pkgs.kitty ];
  };
}
