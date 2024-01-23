{ ... }: {
  config = {
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    } // import ./config.nix;
  };
}
