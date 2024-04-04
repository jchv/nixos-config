{ config, ... }:
{
  imports = [ ./librewolf.nix ];
  config = {
    home.stateVersion = "23.11";
    xdg.userDirs.enable = true;

    # This shouldn't be necessary, but it works around KDE bugs.
    home.file.".local/share/applications/mimeapps.list".source = config.lib.file.mkOutOfStoreSymlink "/etc/xdg/mimeapps.list";
  };
}
