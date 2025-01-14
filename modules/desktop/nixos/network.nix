{ pkgs, lib, ... }:
{
  config = {
    # Workaround for https://github.com/NixOS/nixpkgs/issues/180175
    systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

    networking = {
      # TODO: Probably would be good to re-enable, but it's annoying for
      # desktop systems.
      firewall.enable = false;
      networkmanager.enable = true;
      search = [ "jchw.io" ];
    };

    # Enable Avahi.
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
          domain = true;
          hinfo = true;
          userServices = true;
          workstation = true;
        };
      };
    };

    environment.systemPackages = [ pkgs.networkmanagerapplet ];
  };
}
