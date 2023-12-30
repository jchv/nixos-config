{ pkgs, ... }: {
  config = {
    environment.systemPackages = [ pkgs.cifs-utils ];
    security.pam.mount.enable = true;
    security.pam.mount.extraVolumes = [
      ''<volume user="john" fstype="cifs" server="scarlet" path="home" mountpoint="/media/scarlet-home"/>''
    ];
  };
}
