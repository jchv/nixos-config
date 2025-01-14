{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      iptables
      psmisc
    ];

    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };
  };
}
