{ config, lib, ... }:
{
  options = {
    jchw.apc-ups.enable = lib.mkEnableOption "APC UPS support";
  };

  config = lib.mkIf config.jchw.apc-ups.enable {
    sops.secrets = {
      "upsmon/password" = { };
    };
    power.ups = {
      enable = true;
      ups."apc" = {
        driver = "usbhid-ups";
        port = "auto";
        description = "APC UPS";
      };
      users.upsmon = {
        passwordFile = config.sops.secrets."upsmon/password".path;
        upsmon = "primary";
      };
      upsmon.monitor."apc".user = "upsmon";
    };
  };
}
