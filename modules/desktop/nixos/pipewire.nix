{ pkgs, ... }:
{
  config = {
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez;
      settings = {
        General = {
          # ControllerMode = "le";
          Experimental = true;
          KernelExperimental = true;
        };
      };
    };
    environment.systemPackages = [
      pkgs.pulsemixer
    ];
    system.replaceDependencies.replacements = [
      {
        oldDependency = pkgs.pipewire;
        newDependency = pkgs.pipewire.overrideAttrs (
          finalAttrs: prevAttrs: {
            patches = (prevAttrs.patches or [ ]) ++ [
              (pkgs.writeText "pipewire-32khz.diff" ''
                diff --git a/spa/plugins/bluez5/bap-codec-lc3.c b/spa/plugins/bluez5/bap-codec-lc3.c
                index e9b7723..8e0d882 100644
                --- a/spa/plugins/bluez5/bap-codec-lc3.c
                +++ b/spa/plugins/bluez5/bap-codec-lc3.c
                @@ -647,13 +647,17 @@ static bool select_config(bap_lc3_t *conf, const struct pac_data *pac,	struct sp
                 	 * Frame length is not limited by ISO MTU, as kernel will fragment
                 	 * and reassemble SDUs as needed.
                 	 */
                -	if (pac->sink && pac->duplex) {
                +	if (pac->duplex) {
                 		/* 16KHz input is mandatory in BAP v1.0.1 Table 3.5, so prefer
                -		 * it for now for input rate in duplex configuration.
                +		 * it or 32kHz for now for input rate in duplex configuration.
                +		 *
                +		 * It appears few devices support 48kHz out + input, so in duplex mode
                +		 * try 32 kHz or 16 kHz also for output direction.
                 		 *
                 		 * Devices may list other values but not certain they will work properly.
                 		 */
                -		bap_qos = select_bap_qos(rate_mask & LC3_FREQ_16KHZ, duration_mask, framelen_min, framelen_max);
                +		bap_qos = select_bap_qos(rate_mask & (LC3_FREQ_16KHZ & LC3_FREQ_32KHZ),
                +				duration_mask, framelen_min, framelen_max);
                 	}
                 	if (!bap_qos)
                 		bap_qos = select_bap_qos(rate_mask, duration_mask, framelen_min, framelen_max);
                @@ -752,8 +756,8 @@ static int conf_cmp(const bap_lc3_t *conf1, int res1, const bap_lc3_t *conf2, in
                 	PREFER_BOOL(conf->channels & LC3_CHAN_2);
                 	PREFER_BOOL(conf->channels & LC3_CHAN_1);

                -	if (conf->sink && conf->duplex)
                -		PREFER_BOOL(conf->rate & LC3_CONFIG_FREQ_16KHZ);
                +	if (conf->duplex)
                +		PREFER_BOOL(conf->rate & (LC3_CONFIG_FREQ_16KHZ | LC3_CONFIG_FREQ_32KHZ));

                 	PREFER_EXPR(conf->priority);

              '')
            ];
          }
        );
      }
      #{
      #  oldDependency = pkgs.bluez;
      #  newDependency = pkgs.bluez.overrideAttrs (
      #    finalAttrs: prevAttrs: {
      #      version = "5.82";
      #      src = pkgs.fetchurl {
      #        url = "mirror://kernel/linux/bluetooth/bluez-${finalAttrs.version}.tar.xz";
      #        hash = "sha256-Bzn6YIqDeWfubVVytD+4mUapONHGwmEnFYqu/XQ6eQs=";
      #      };
      #    }
      #  );
      #}
    ];
  };
}
