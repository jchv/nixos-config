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

    # Allow sudo using ssh-agent authentication
    security.pam.sshAgentAuth.enable = true;

    # Fix for pam_ssh_agent_auth which is currently broken.
    nixpkgs.overlays = [
      (final: prev: {
        pam_ssh_agent_auth = prev.pam_ssh_agent_auth.overrideAttrs (prevAttrs: {
          nativeBuildInputs = (prevAttrs.nativeBuildInputs or [ ]) ++ [
            final.autoreconfHook
          ];
          patches = (prevAttrs.patches or [ ]) ++ [
            (final.fetchDebianPatch {
              pname = "pam-ssh-agent-auth";
              version = "0.10.3";
              debianRevision = "11";
              patch = "fix-configure.patch";
              hash = "sha256-ymXv2o/NpFeVQ6r0hvJEeMpvs5Ht9jq4RSw8ssv43FY=";
            })
            (final.fetchDebianPatch {
              pname = "pam-ssh-agent-auth";
              version = "0.10.3";
              debianRevision = "11";
              patch = "1000-gcc-14.patch";
              hash = "sha256-EvdaIhrfKZ1mB7qvNiGx/hYdthStgnhK7xvJEhhAFDQ=";
            })
          ];
        });
      })
    ];

    # Necessary to be able to remotely use nixos-rebuild with agent auth.
    environment.variables.NIX_SSHOPTS = "-o ForwardAgent=yes";
  };
}
