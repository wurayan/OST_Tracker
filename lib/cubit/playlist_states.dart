part of 'playlist_cubit.dart';

abstract class PlaylistStates {}

class PLaylistLoading extends PlaylistStates {}

class PlaylistSuccess extends PlaylistStates {
  final List<Playlist> playlists;
  PlaylistSuccess(this.playlists);
}

class PlaylistEmpty extends PlaylistStates {
  final String msg;
  PlaylistEmpty(this.msg);
}

class PlaylistError extends PlaylistStates {
  final String msg;
  PlaylistError(this.msg);
}
