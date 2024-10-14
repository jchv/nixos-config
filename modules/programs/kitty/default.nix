{ lib, pkgs, ... }:
{
  config = {
    environment.etc."xdg/kitty/kitty.conf".source = ./kitty.conf;
    environment.systemPackages = [
      pkgs.kitty
      (pkgs.runCommand "x-terminal-emulator" { } ''
        mkdir -p $out/bin
        ln -s ${lib.getExe pkgs.kitty} $out/bin/x-terminal-emulator
      '')
    ];
  };
}
