{
  config = {
    services.openssh = {
      settings.X11Forwarding = true;
      enable = true;
    };

    programs.ssh.extraConfig = ''
      AddKeysToAgent confirm
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

  };
}
