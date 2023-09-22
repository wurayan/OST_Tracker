import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:ost_tracker_og/models/musica_model.dart';
import 'package:ost_tracker_og/service/musica.dart';

part 'musica_states.dart';

class MusicaCubit extends Cubit<MusicaStates> {
  MusicaCubit() : super(MusicaLoading());
  final MusicaFirestore _musica = MusicaFirestore();

  List<Musica> allMusicas = [];

  Future<void> getMusicas() async {
    try {
      final List<Musica> musicas = await _musica.getMusicas();
      if (musicas.isEmpty) {
        emit(MusicaEmpty("Não encontramos nenhuma música"));
      } else {
        allMusicas = musicas;
        emit(MusicaSuccess(musicas));
      }
    } catch (e) {
      emit(MusicaError(e.toString()));
    }
  }

  Future<void> getOnlyMusicas(List<String> lista) async {
    try {
      final List<Musica> res = await _musica.getMusicas();
      final matchingSet = HashSet.from(lista);
      List<Musica> musicas =
          res.where((element) => matchingSet.contains(element.id)).toList();
      if (lista.isEmpty || musicas.isEmpty) {
        emit(MusicaEmpty("Não encontramos nenhuma música"));
      } else {
        emit(MusicaSuccess(musicas));
      }
    } catch (e) {
      emit(MusicaError(e.toString()));
    }
  }

  Future<void> searchMusica(String search) async {
    List<Musica> musicas = allMusicas
        .where((e) => e.nome.toUpperCase().contains(search.toUpperCase()))
        .toList();
    if (musicas.isEmpty) {
      emit(MusicaEmpty("Não encontramos nenhuma música"));
    } else {
      emit(MusicaSuccess(musicas));
    }
  }
}
