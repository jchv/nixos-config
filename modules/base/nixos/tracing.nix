{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      pkgs.babeltrace2
      pkgs.lttng-tools
    ];

    systemd.services.lttng-sessiond = {
      description = "LTTng Session Daemon";
      wantedBy = [ "multi-user.target" ];
      environment.MODULE_DIR = "/run/current-system/kernel-modules/lib/modules";
      serviceConfig = {
        ExecStart = "${pkgs.lttng-tools}/bin/lttng-sessiond";
      };
    };
  };
}
