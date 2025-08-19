{ lib, pkgs, ... }:
{
  home.activation = {
    configureVlc = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # Ensure the default config exists first.
      #
      # It shouldn't make any functional difference, but the default config
      # contains useful documentation.
      if [ ! -f $HOME/.config/vlc/vlcrc ]; then
        verboseEcho "Running VLC to set up default config."
        run ${pkgs.vlc}/bin/cvlc --reset-config --verbose -1 vlc://quit
      fi

      # Set the fluidsynth default soundfont.
      run ${lib.getExe pkgs.godini} set $HOME/.config/vlc/vlcrc --section fluidsynth soundfont=${./gm.sf2}
    '';
  };
}
