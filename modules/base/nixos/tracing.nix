{ pkgs, config, ... }:
{
  config = {
    environment.systemPackages = [
      pkgs.babeltrace2
      pkgs.lttng-tools
    ];

    # boot.extraModulePackages = with config.boot.kernelPackages; [
    #   (lttng-modules.overrideAttrs (
    #     final: prev: {
    #       version = "2.14.0";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "lttng";
    #         repo = "lttng-modules";
    #         rev = "v2.14.0";
    #         hash = "sha256-70sCMyQA2Hfmimmv2Ea1f+zXGwms3MQ7xyTcOZfwT/A=";
    #       };
    #     }
    #   ))
    # ];

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
