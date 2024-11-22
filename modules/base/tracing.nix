{ config, pkgs, ... }:
{
  config = {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      (lttng-modules.overrideAttrs (
        final: prev: {
          version = "2.13.16";
          src = pkgs.fetchFromGitHub {
            owner = "lttng";
            repo = "lttng-modules";
            rev = "v2.13.16";
            hash = "sha256-6SzKpBuKC98v2PbeyDoxEbt3i6KEztpOk0wlvP4NWBA=";
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
