{
  imports = [
    ./librewolf.nix
  ];
  config = {
    home.stateVersion = "23.11";
    xdg.userDirs.enable = true;
  };
}
