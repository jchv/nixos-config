{ pkgs, ... }: {
  config = {
    # Can work around hanging nixos-rebuild switch.
    systemd.services.NetworkManager.reloadIfChanged = false;

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

    environment.systemPackages = with pkgs; [
      networkmanagerapplet
    ];
  };
}
