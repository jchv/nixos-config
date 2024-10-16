{ config, pkgs, ... }:
{
  config = {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      (lttng-modules.overrideAttrs (
        final: prev: {
          version = "2.13.15";
          src = pkgs.fetchFromGitHub {
            owner = "lttng";
            repo = "lttng-modules";
            rev = "v2.13.15";
            hash = "sha256-cEiv1EjsEvyreRERrCGKKpJdA1IKvuyVmgA7S3EkEnU=";
          };
        }
      ))
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
