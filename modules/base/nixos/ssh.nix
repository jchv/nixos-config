{
  config = {
    services.openssh = {
      settings.X11Forwarding = true;
    };

    # Allow sudo using ssh-agent authentication
    security.pam.sshAgentAuth.enable = true;
  };
}
