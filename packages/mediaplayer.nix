{ pkgs, ... }:

pkgs.writers.writePython3 "mediaplayer" {
  libraries = with pkgs; [
    python3Packages.pygobject3
    playerctl
    python3
  ];
}
''
  # flake8: noqa
  import os
  import argparse
  import logging
  import sys
  import signal
  import gi
  import json
  from functools import partial
  os.environ["GI_TYPELIB_PATH"] = "${pkgs.playerctl.out}/lib/girepository-1.0"
  gi.require_version('Playerctl', '2.0')
  from gi.repository import Playerctl, GLib

  logger = logging.getLogger(__name__)

  def parse_arguments():
      parser = argparse.ArgumentParser()

      # Increase verbosity with every occurrence of -v
      parser.add_argument('-v', '--verbose', action='count', default=0)

      return parser.parse_args()

  arguments = parse_arguments()

  def write_output(text, player):
      logger.info('Writing output')

      output = {'text': text,
                'class': 'custom-' + player.props.player_name,
                'alt': player.props.player_name}

      sys.stdout.write(json.dumps(output) + '\n')
      sys.stdout.flush()

  def on_play(player, status, manager):
      logger.info('Received new playback status')
      on_metadata(player, player.props.metadata, manager)

  def on_metadata(player, metadata, manager):
      logger.info('Received new metadata')
      track_info = ""

      if player.props.player_name == 'spotify' and \
              'mpris:trackid' in metadata.keys() and \
              ':ad:' in player.props.metadata['mpris:trackid']:
          track_info = 'AD PLAYING'
      elif player.get_artist() != "" and player.get_title() != "":
          track_info = '{artist} - {title}'.format(artist=player.get_artist(),
                                                    title=player.get_title())
      else:
          track_info = player.get_title()

      if player.props.status != 'Playing' and track_info:
          track_info = ' ' + track_info
      write_output(track_info, player)


  def on_player_appeared(manager, player):
      if player is None:
          return
      init_player(manager, player)

  def on_player_vanished(manager, player):
      logger.info('Player has vanished')
      sys.stdout.write('\n')
      sys.stdout.flush()

  def init_player(manager, name):
      logger.debug('Initialize player: {player}'.format(player=name.name))
      player = Playerctl.Player.new_from_name(name)
      player.connect('playback-status', on_play, manager)
      player.connect('metadata', on_metadata, manager)
      manager.manage_player(player)
      on_metadata(player, player.props.metadata, manager)

  def signal_handler(sig, frame):
      logger.debug('Received signal to stop, exiting')
      sys.stdout.write('\n')
      sys.stdout.flush()
      # loop.quit()
      sys.exit(0)

  def main():
      # Initialize logging
      logging.basicConfig(stream=sys.stderr, level=logging.DEBUG,
                          format='%(name)s %(levelname)s %(message)s')

      # Logging is set by default to WARN and higher.
      # With every occurrence of -v it's lowered by one
      logger.setLevel(max((3 - arguments.verbose) * 10, 0))

      # Log the sent command line arguments
      logger.debug('Arguments received {}'.format(vars(arguments)))

      manager = Playerctl.PlayerManager()
      loop = GLib.MainLoop()

      manager.connect('name-appeared', on_player_appeared)
      manager.connect('player-vanished', on_player_vanished)

      signal.signal(signal.SIGINT, signal_handler)
      signal.signal(signal.SIGTERM, signal_handler)
      signal.signal(signal.SIGPIPE, signal.SIG_DFL)

      for player in manager.props.player_names:
          init_player(manager, player)

      loop.run()


  if __name__ == '__main__':
      main()
''
