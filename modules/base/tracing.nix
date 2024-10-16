{ config, pkgs, ... }:
{
  config = {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      lttng-modules
    ];

    environment.systemPackages = with pkgs; [
      babeltrace2
      lttng-tools
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
