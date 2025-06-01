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
          ControllerMode = "le";
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
            src = pkgs.fetchFromGitLab {
              domain = "gitlab.freedesktop.org";
              owner = "pipewire";
              repo = "pipewire";
              rev = "2cec77e7df1a4a6a98b87981d818e0eea727e0fa";
              sha256 = "sha256-BSC/jEUbPiNZka3E/JcTib1Y+2v3qR76zJ/LLhc7pyI=";
            };
            mesonFlags = prevAttrs.mesonFlags ++ [
              (pkgs.lib.mesonEnable "bluez5-codec-ldac-dec" false)
            ];
          }
        );
      }
      {
        oldDependency = pkgs.bluez;
        newDependency = pkgs.bluez.overrideAttrs (
          finalAttrs: prevAttrs: {
            version = "5.82";
            src = pkgs.fetchurl {
              url = "mirror://kernel/linux/bluetooth/bluez-${finalAttrs.version}.tar.xz";
              hash = "sha256-Bzn6YIqDeWfubVVytD+4mUapONHGwmEnFYqu/XQ6eQs=";
            };
          }
        );
      }
    ];
  };
}
