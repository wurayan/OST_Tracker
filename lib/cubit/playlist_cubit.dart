import 'package:bloc/bloc.dart';
import 'package:ost_tracker_og/models/playlist_model.dart';
import 'package:ost_tracker_og/service/playlist.dart';

part 'playlist_states.dart';

class PlaylistCubit extends Cubit<PlaylistStates> {
  PlaylistCubit() : super(PLaylistLoading());
  final PlaylistFirestore _playlist = PlaylistFirestore();

  List<Playlist> allPlaylists = [];

  Future<void> getPlaylists() async {
    try {
      final List<Playlist> playlist = await _playlist.getPlaylists();
      if (playlist.isEmpty) {
        emit(PlaylistEmpty("Não encontramos nenhuma PLaylist"));
      } else {
        allPlaylists = playlist;
        emit(PlaylistSuccess(playlist));
      }
    } catch (e) {
      emit(PlaylistError(e.toString()));
    }
  }

  Future<void> searchPlaylists(String search) async {
    List<Playlist> playlist = allPlaylists
        .where((e) => e.nome.toUpperCase().contains(search.toUpperCase()))
        .toList();
    if (playlist.isEmpty) {
      emit(PlaylistEmpty("Não encontramos nenhuma Playlist"));
    } else {
      emit(PlaylistSuccess(playlist));
    }
  }
}
