{ config, lib, ... }:
{
  options = {
    jchw.u2f = {
      enable = lib.mkEnableOption "U2F support";
      sudo.enable = lib.mkEnableOption "sudo via FIDO2";
      screenLock.enable = lib.mkEnableOption "screen unlocking via FIDO2";
    };
  };

  config = lib.mkIf config.jchw.u2f.enable {
    sops.secrets = {
      "u2f/authMapping" = {
        mode = "0444";
      };
    };

    security.pam.u2f.settings.authfile = config.sops.secrets."u2f/authMapping".path;

    # Allow sudo with U2F
    security.pam.services.sudo = lib.mkIf config.jchw.u2f.sudo.enable {
      u2fAuth = true;
      rules.auth.u2f.args = lib.mkAfter [
        "pinverification=0"
        "userverification=1"
      ];
    };
  };
}
