{ pkgs, inputs, config, ... }:
{
  config = {
    sops.secrets = {
      "nix/secret-key" = { };
    };
    environment = {
      etc = {
        "channels/nixpkgs".source = inputs.nixpkgs.outPath;
        "channels/system".source = inputs.self.outPath;
      };
      shellInit = ''
        zlibd() (printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" | cat - "$@" | gzip -dc)
      '';
      systemPackages = [
        pkgs.age
        pkgs.fd
        pkgs.file
        pkgs.gh
        pkgs.go
        pkgs.iptables
        pkgs.jq
        pkgs.killport
        pkgs.libarchive
        pkgs.magic-wormhole-rs
        pkgs.moreutils
        pkgs.nix-index
        pkgs.nix-output-monitor
        pkgs.pciutils
        pkgs.psmisc
        pkgs.ripgrep
        pkgs.sops
        pkgs.unar
        pkgs.usbutils
        pkgs.vim
      ];
      variables = {
        EDITOR = "vim";
        # Necessary to be able to remotely use nixos-rebuild with agent auth.
        NIX_SSHOPTS = "-o ForwardAgent=yes";
      };
    };
    nix = {
      settings = {
        sandbox = true;
        cores = 0;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        secret-key-files = config.sops.secrets."nix/secret-key".path;
        extra-trusted-public-keys = "jchw:6KUKtpuykOWMdecyfgKbRW9boZkflWgB5PHi+O9sST4=";
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 14d";
      };
      registry = {
        nixpkgs.flake = inputs.nixpkgs;
        system.flake = inputs.self;
      };
      nixPath = [
        "nixpkgs=${inputs.nixpkgs}"
        "system=${inputs.self}"
      ];
    };
    nixpkgs = {
      config.allowBroken = true;
    };
    programs = {
      git = {
        enable = true;
        package = pkgs.gitFull;
      };
      fuse.userAllowOther = true;
      zsh = {
        enable = true;
        enableCompletion = true;
      };
      nix-index.enable = false;
      nix-index-database.comma.enable = true;
      direnv = {
        enable = true;
      };
      ssh.extraConfig = ''
        AddKeysToAgent confirm
        Compression yes
        ServerAliveInterval 5
        ServerAliveCountMax 3
        SetEnv TERM=xterm-256color
        Host *
          ControlMaster auto
          ControlPath ~/.ssh/control-%r@%h:%p
          ControlPersist 10m
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
    };
    services = {
      openssh = {
        enable = true;
      };
    };
    sops = {
      defaultSopsFile = ../../secrets/default.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
    time = {
      timeZone = "America/Detroit";
    };
  };
}
