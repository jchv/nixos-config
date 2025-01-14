{
  services.syncthing = {
    enable = true;
    user = "john";
    group = "users";
    dataDir = "/home/john/.local/state/syncthing";
    configDir = "/home/john/.config/syncthing";
    overrideDevices = false;
    overrideFolders = false;
    settings.gui = {
      user = "john";
      password = "todo";
    };
  };
}
