{
  config = {
    programs.sway.extraSessionCommands = ''
      export GNOME_KEYRING_CONTROL=/run/user/$UID/keyring
      export SSH_AUTH_SOCK=/run/user/$UID/keyring/ssh
    '';

    services.gnome.gnome-keyring.enable = true;
  };
}
