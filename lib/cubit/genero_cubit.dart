import 'package:bloc/bloc.dart';
import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/service/genero.dart';

import 'generic_state.dart';

part 'genero_states.dart';

class GeneroCubit extends Cubit<GenericState> {
  GeneroCubit() : super(GeneroLoading());
  final GeneroFirestore _genero = GeneroFirestore();

  List<Genero> allGeneros = [];

  Future<void> getGeneros() async {
    try {
      final List<Genero> generos = await _genero.getGeneros();
      if (generos.isEmpty) {
        emit(GeneroEmpty("Não encontramos nenhum gênero"));
      } else {
        allGeneros = generos;
        emit(GeneroSuccess(generos));
      }
    } catch (e) {
      emit(GeneroError(e.toString()));
    }
  }

  void searchGenero(String search) {
    List<Genero> generos = allGeneros
        .where((e) => e.nome.toUpperCase().contains(search.toUpperCase()))
        .toList();
    if (generos.isEmpty) {
      emit(GeneroEmpty("Não encontramos nenhum Gênero."));
    } else {
      emit(GeneroSuccess(generos));
    }
  }
}
