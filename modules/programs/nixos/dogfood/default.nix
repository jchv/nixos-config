{ lib, pkgs, ... }:
{
  options = {
    jchw.dogfood = {
      enable = lib.mkEnableOption "Upstream patch dogfooding" // {
        default = true;
      };
    };
  };

  config = {
    system.replaceDependencies.replacements = [
      # Currently under review. Might arrive in KDE Frameworks 6.8.0.
      # https://invent.kde.org/frameworks/kio/-/merge_requests/1731
      {
        oldDependency = pkgs.kdePackages.kio;
        newDependency = pkgs.kdePackages.kio.overrideAttrs (
          finalAttrs: prevAttrs: {
            # Manually rebased onto KIO 6.7.0 due to merge conflicts.
            patches = (prevAttrs.patches or [ ]) ++ [
              ./0001-PreviewJob-Use-kio-fuse-for-remote-files.patch
            ];
          }
        );
      }
      # Merged into kio-extras, should be in next KDE gear release.
      # Check back in December.
      {
        oldDependency = pkgs.kdePackages.kio-extras;
        newDependency = pkgs.kdePackages.kio-extras.overrideAttrs {
          src = pkgs.fetchurl {
            url = "https://invent.kde.org/network/kio-extras/-/archive/0200554c98dd745f81d0b060872880bb3fb113a6/kio-extras-0200554c98dd745f81d0b060872880bb3fb113a6.tar.gz";
            hash = "sha256-ZYYZrv6NEAXo+SQZlzs+uzG9GTXdf+ISw2AbBSf32Bk=";
          };
        };
      }
    ];
  };
}
