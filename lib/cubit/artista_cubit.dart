import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/cubit/generic_state.dart';
import 'package:ost_tracker_og/models/artista_model.dart';
import 'package:ost_tracker_og/service/artista.dart';

part 'artista_states.dart';

class ArtistaCubit extends Cubit<GenericState> {
  ArtistaCubit() : super(ArtistaLoading());
  final ArtistaFirestore _artista = ArtistaFirestore();

  List<Artista> allArtistas = [];

  Future<void> getArtistas() async {
    try {
      List<Artista> artistas = await _artista.getArtistas();
      if (artistas.isEmpty) {
        emit(ArtistaEmpty("Não encontramos nenhum Artista"));
      } else {
        allArtistas = artistas;
        emit(ArtistaSuccess(artistas));
      }
    } catch (e) {
      emit(ArtistaError(e.toString()));
    }
  }

  searchArtista(String search) {
    List<Artista> artistas = allArtistas
        .where((e) => e.nome.toUpperCase().contains(search.toUpperCase()))
        .toList();
    if (artistas.isEmpty) {
      emit(ArtistaEmpty("Não encontramos nenhum Artista"));
    } else {
      allArtistas = artistas;
      emit(ArtistaSuccess(artistas));
    }
  }
}
