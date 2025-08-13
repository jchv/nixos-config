{
  imports = [
    ./common.nix
  ];
  config = {
    nix.settings.extra-sandbox-paths = [
      "/nix/store"
    ];
  };
}
