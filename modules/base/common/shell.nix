{ pkgs, ... }:
{
  config = {
    # Zshell
    programs.zsh = {
      enable = true;
    };

    environment.systemPackages = [
      pkgs.zsh-completions
    ];

    programs.nix-index.enable = false;
    programs.nix-index-database.comma.enable = true;

    # Direnv
    programs.direnv = {
      enable = true;
    };

    # Environment
    environment = {
      variables.EDITOR = "vim";
      shellInit = ''
        zlibd() (printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" | cat - "$@" | gzip -dc)
      '';
    };
  };
}
