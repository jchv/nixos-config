{
  config = {
    services.openssh = {
      enable = true;
    };

    programs.ssh.extraConfig = ''
      AddKeysToAgent confirm
      Compression yes
      ServerAliveInterval 5
      ServerAliveCountMax 3
      SetEnv TERM=xterm-256color

      Host andou andou.local curly curly.local mii mii.local puchiko puchiko.local taiga taiga.local
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

    # Necessary to be able to remotely use nixos-rebuild with agent auth.
    environment.variables.NIX_SSHOPTS = "-o ForwardAgent=yes";
  };
}
