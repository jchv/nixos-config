{ pkgs, ... }:
{
  config = {
    programs.ssh.askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
  };
}
