{ pkgs, ... }: {
  config = {
    systemd.user.services.fluidsynth = {
      description = "FluidSynth Daemon";
      documentation = [ "man:fluidsynth(1)" ];
      after = [ "sound.target" "pipewire.service" ];
      wantedBy = [ "default.target" ];
      restartIfChanged = true;
      serviceConfig = {
        ProtectSystem = "full";
        ProtectHome = "read-only";
        ProtectHostname = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        PrivateUsers = "yes";
        Type = "exec";
        ExecStart = ''${pkgs.fluidsynth.out}/bin/fluidsynth -is -a pulseaudio -m alsa_seq -p "FluidSynth GM" -r 48000 ${./gm.sf2}'';
      };
    };
  };
}
