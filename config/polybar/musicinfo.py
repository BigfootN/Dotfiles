#!/usr/bin/python

import subprocess
import dbus
import chardet
import argparse
import sys
from enum import Enum
from mpd import MPDClient


class PlayerCommand(Enum):
    NEXT = 1
    PREV = 2
    PAUSE = 3
    PLAY_PAUSE = 4
    STOP = 5
    PLAY = 6


class PlayerStatus(Enum):
    PLAYING = 1
    STOPPED = 2
    PAUSED = 3
    UNKNOWN = 4


def init_arguments():
    parser = argparse.ArgumentParser(description="Universal music controller")
    subparsers = parser.add_subparsers(
        title="subcommands",
        description="Print current song or send command", dest="action")

    print_song_parser = subparsers.add_parser(
        'song', help="Print current song")
    send_command_parser = subparsers.add_parser('command', help="Send command")

    print_song_parser.add_argument(
        'format',
        type=str,
        nargs=1,
        help="The format of the song with %a = Artist, %b = Album, %t = Title, %y = Year")
    send_command_parser.add_argument(
        'command',
        type=str,
        choices=[
            'next',
            'pause',
            'previous',
            'playpause',
            'stop',
            'play'],
        help="The command to send")

    parser.add_argument(
        '--type',
        '-t',
        required=False,
        dest='player_type',
        choices=[
            'mpd',
            'mpris'],
        nargs=1,
        default='mpris',
        help="The prefered player type (if the player with the specified type is not found the other will be chosen). If none were specified the first active player will be chosen")
    parser.add_argument(
        '--mpdhost',
        type=str,
        dest='mpd_host',
        default='localhost',
        required=False,
        help="The adress of mpd")
    parser.add_argument(
        '--mpdport',
        type=int,
        dest='mpd_port',
        default=6600,
        required=False,
        help="The port of mpd")
    args = parser.parse_args()
    return args


def parse_arguments(args, player):
    command_map_str = {
        'next': PlayerCommand.NEXT,
        'previous': PlayerCommand.PREV,
        'playpause': PlayerCommand.PLAY_PAUSE,
        'stop': PlayerCommand.STOP,
        'pause': PlayerCommand.PAUSE,
        'play': PlayerCommand.PLAY
    }

    if args.action == 'command':
        player.send_command(command_map_str[args.command])
    elif args.action == 'song':
        song = player.current_song()
        try:
            song_str = song.format_str(args.format[0])
        except UnicodeError as e:
            sys.exit("ERROR! " + e.args[1])
        print(song_str)


def get_all_active_dbus_services():
    conn = DBusConnection(
        "/org/freedesktop/DBus",
        "org.freedesktop.DBus",
        "org.freedesktop.DBus")
    ret = conn.call_method("ListNames")
    return ret


def get_all_active_mpris_services():
    ret = []
    dbus_services = get_all_active_dbus_services()
    for service in dbus_services:
        if "org.mpris.MediaPlayer2" in service:
            ret.append(service)
    return ret


def get_active_mpris_player():
    ret = None
    active_mpris_services = get_all_active_mpris_services()
    for mpris_service in active_mpris_services:
        player_name = mpris_service.split('.')[-1]
        player = MprisMediaPlayer(player_name)
        if (player.status() != PlayerStatus.STOPPED):
            ret = player
            break
    return ret


def get_active_player(player_type, mpd_host, mpd_port):
    ret = None
    if player_type == "mpd":
        ret = MpdPlayer(mpd_host, mpd_port)
        mpd_active = ret.connect()
        if (not mpd_active) or (ret.status() == PlayerStatus.STOPPED):
            ret = get_active_mpris_player()
    else:
        ret = get_active_mpris_player()
        if ret is None:
            ret = MpdPlayer(mpd_host, mpd_port)
            if not ret.is_up():
                ret = None
    return ret


class Song:
    def __init__(self, title=None, album=None, artist=None, year=0):
        self._title = title
        self._album = album
        self._artist = artist
        self._year = 0

    def format_str(self, string):
        ret = ""
        idx = 0
        map_format_str = {'a': self._artist,
                          'b': self._album,
                          'y': self._year,
                          't': self._title}
        while idx < len(string):
            c = string[idx]
            if c == '%':
                idx += 1
                if string[idx] in map_format_str:
                    ret += map_format_str[string[idx]]
                else:
                    exception = UnicodeError(
                        "utf8",
                        "Unknown tag: %" + string[idx],
                        idx,
                        idx,
                        string)
                    raise exception
            else:
                ret += c
            idx += 1
        return ret

    @property
    def title(self):
        return self._title

    @title.setter
    def title(self, value):
        self._title = value

    @property
    def album(self):
        return self._album

    @album.setter
    def album(self, value):
        self._album = value

    @property
    def year(self):
        return self._album

    @year.setter
    def year(self, value):
        self._year = value

    @property
    def artist(self):
        return self._artist

    @artist.setter
    def artist(self, value):
        self._artist = value


class Player:
    def __init__(self):
        self._map_commands = {PlayerCommand.NEXT: self._next,
                              PlayerCommand.PAUSE: self._pause,
                              PlayerCommand.STOP: self._stop,
                              PlayerCommand.PREV: self._prev,
                              PlayerCommand.PLAY_PAUSE: self._play_pause,
                              PlayerCommand.PLAY: self._play}

    def send_command(self, player_command):
        command = self._map_commands[player_command]
        command()


class MpdPlayer(Player):
    def __init__(self, host, port):
        Player.__init__(self)
        self._host = host
        self._port = port
        self._client = MPDClient()
        self._client.timeout = 10

    def connect(self):
        ret = False
        try:
            self._client.connect(self._host, self._port)
            ret = True
        except BaseException:
            pass
        return ret

    def status(self):
        self._client.command_list_ok_begin()
        self._client.status()
        status = self._client.command_list_end()[0]["state"]
        ret = {'play': PlayerStatus.PLAYING,
               'stop': PlayerStatus.STOPPED,
               'pause': PlayerStatus.PAUSED}[status]
        return ret

    def is_up(self):
        ret = False
        try:
            MPDClient().connect(self._port, self._host)
            ret = True
        except BaseException:
            pass
        return ret

    def current_song(self):
        ret = Song()
        self._client.command_list_ok_begin()
        self._client.currentsong()
        mpd_song = self._client.command_list_end()[0]
        ret.artist = mpd_song['artist']
        ret.album = mpd_song['album']
        ret.title = mpd_song['title']
        ret.year = int(mpd_song['date'])
        return ret

    def _pause(self):
        self._client.command_list_ok_begin()
        self._client.pause(1)
        self._client.command_list_end()

    def _play(self):
        self._client.command_list_ok_begin()
        self._client.play()
        self._client.command_list_end()

    def _next(self):
        self._client.command_list_ok_begin()
        self._client.next()
        self._client.command_list_end()

    def _prev(self):
        self._client.command_list_ok_begin()
        self._client.previous()
        self._client.command_list_end()

    def _stop(self):
        self._client.command_list_ok_begin()
        self._client.stop()
        self._client.command_list_end()

    def _play_pause(self):
        self._client.command_list_ok_begin()
        self._client.status()
        status = self._client.command_list_end()[0]["status"]
        if not status == "play":
            self._play()
        else:
            self._pause()


class DBusConnection:
    def __init__(self, object_path, bus_name, interface_name):
        self._bus = dbus.SessionBus()
        self._proxy = self._bus.get_object(bus_name, object_path)
        self._interface = dbus.Interface(
            self._proxy, dbus_interface=interface_name)

    def call_method(self, method_name):
        ret = self._interface.get_dbus_method(method_name)()
        return ret

    def get_property(self, property_name):
        ret = self._proxy.get_dbus_method(
            "Get", "org.freedesktop.DBus.Properties")
        return ret(self._interface.dbus_interface, property_name)


class MprisMediaPlayer(Player):
    def __init__(self, name):
        Player.__init__(self)
        self._media_player = DBusConnection(
            "/org/mpris/MediaPlayer2",
            "org.mpris.MediaPlayer2." + name,
            "org.mpris.MediaPlayer2")
        self._media_player_player = DBusConnection(
            "/org/mpris/MediaPlayer2",
            "org.mpris.MediaPlayer2." + name,
            "org.mpris.MediaPlayer2.Player")
        self._media_player_tracklist = DBusConnection(
            "/org/mpris/MediaPlayer2",
            "org.mpris.MediaPlayer2." + name,
            "org.mpris.MediaPlayer2.TrackList")
        self._media_player_playlists = DBusConnection(
            "/org/mpris/MediaPlayer2",
            "org.mpris.MediaPlayer2." + name,
            "org.mpris.MediaPlayer2.PlayLists")

    def current_song(self):
        ret = Song()
        metadata_map = self._media_player_player.get_property("Metadata")
        ret.artist = metadata_map["xesam:artist"][0]
        ret.album = metadata_map["xesam:album"]
        ret.title = metadata_map["xesam:title"]
        return ret

    def status(self):
        status = self._media_player_player.get_property("PlaybackStatus")
        ret = {'Playing': PlayerStatus.PLAYING,
               'Stopped': PlayerStatus.STOPPED,
               'Paused': PlayerStatus.PAUSED}[status]
        return ret

    def _play(self):
        self._media_player_player.call_method("Pause")

    def _next(self):
        self._media_player_player.call_method("Next")

    def _stop(self):
        self._media_player_player.call_method("Stop")

    def _prev(self):
        self._media_player_player.call_method("Previous")

    def _play_pause(self):
        self._media_player_player.call_method("PlayPause")

    def _pause(self):
        self._media_player_player.call_method("Pause")


def main():
    args = init_arguments()
    player = get_active_player(
        args.player_type[0],
        args.mpd_host,
        args.mpd_port)
    if player is not None:
        parse_arguments(args, player)
    else:
        sys.exit("ERROR! No player found")


main()
