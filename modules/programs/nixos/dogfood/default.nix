{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    jchw.dogfood = {
      enable = lib.mkEnableOption "Upstream patch dogfooding" // {
        default = true;
      };
    };
  };

  config = lib.mkIf config.jchw.dogfood.enable {
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
    ];
  };
}
