{ pkgs, ... }: {
  config = {
    # Zshell
    programs.zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "man" ];
        theme = "agnoster";
      };
    };

    # OpenSSH
    services.openssh = {
      settings.X11Forwarding = true;
      enable = true;
    };

    programs.ssh.extraConfig = ''
      AddKeysToAgent yes
      Compression yes
      ServerAliveInterval 5
      ServerAliveCountMax 3
      SetEnv TERM=xterm-256color

      Host curly
        HostName curly
        User john
        ForwardAgent yes

      Host curly.local
        HostName curly.local
        User john
        ForwardAgent yes

      Host gitlab-ssh.ashalcyon.com
        ProxyCommand nix run nixpkgs#cloudflared -- access ssh --hostname %h

      Host codereview.qt-project.org
        Port 29418
        PubkeyAcceptedKeyTypes +ssh-rsa
        User jchw
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/id_ed25519
    '';

    # Eternal Terminal
    services.eternal-terminal.enable = true;

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
      variables.ET_NO_TELEMETRY = "1";
      shellInit = ''
        export PATH="$HOME/bin:$HOME/go/bin:$PATH"
        export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock

        zlibd() (printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" | cat - "$@" | gzip -dc)
      '';
    };
  };
}
