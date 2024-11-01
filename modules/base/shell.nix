{
  config = {
    # Zshell
    programs.zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "man"
        ];
        theme = "agnoster";
      };
    };

    programs.command-not-found.enable = false;
    programs.nix-index-database.comma.enable = true;

    # Tmux
    programs.tmux.enable = true;
    programs.tmux.extraConfig = ''
      set -g mouse on
      bind m set-option mouse\; display-message "Mouse is now #{?mouse,on,off}"
    '';

    # Direnv
    programs.direnv = {
      enable = true;
    };

    # Environment
    environment = {
      variables.EDITOR = "vim";
      shellInit = ''
        export PATH="$HOME/bin:$HOME/go/bin:$PATH"
        export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock

        zlibd() (printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" | cat - "$@" | gzip -dc)
      '';
    };
  };
}
