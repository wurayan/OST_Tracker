import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/components/empty_screen.dart';
import 'package:ost_tracker_og/components/fab.dart';
import 'package:ost_tracker_og/components/loading.dart';
import 'package:ost_tracker_og/cubit/musica_cubit.dart';
import 'package:ost_tracker_og/models/musica_model.dart';
import 'package:ost_tracker_og/models/playlist_model.dart';
import 'package:ost_tracker_og/screens/musica/assets/musica_card_mini.dart';
import 'package:ost_tracker_og/service/playlist.dart';

class BuscarMusicas extends StatefulWidget {
  final Playlist playlist;
  const BuscarMusicas({super.key, required this.playlist});

  @override
  State<BuscarMusicas> createState() => _BuscarMusicasState();
}

class _BuscarMusicasState extends State<BuscarMusicas> {
  final MusicaCubit _musica = MusicaCubit();
  List<String> escolhidas = [];

  searchMusica(String search) {}

  @override
  void initState() {
    escolhidas.addAll(widget.playlist.idMusicas);
    _musica.getMusicas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppbarCustom(
        title: "Buscar Música",
        activeSearch: true,
        onChanged: (value) {
          _musica.searchMusica(value);
        },
        onFieldSubmitted: (value) {
          _musica.searchMusica(value);
        },
      ),
      drawer: const DrawerCustom(),
      floatingActionButton: Fab(
          title: "      VOLTAR      ", function: () => Navigator.pop(context)),
      body: BlocBuilder<MusicaCubit, MusicaStates>(
        bloc: _musica,
        builder: (context, state) {
          if (state is MusicaLoading) {
            return const Loading();
          } else if (state is MusicaEmpty) {
            return Empty(msg: state.msg);
          } else if (state is MusicaError) {
            return Empty(msg: state.error);
          } else if (state is MusicaSuccess) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 32, 12, 0),
              child: ListView.builder(
                  itemCount: state.musicas.length,
                  itemBuilder: (context, index) {
                    Musica musica = state.musicas[index];
                    return MusicaCardMini(
                      musica: musica,
                      navigator: () => _addMusica(musica),
                    );
                  }),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  _addMusica(Musica musica) {
    final PlaylistFirestore firestore = PlaylistFirestore();
    if (escolhidas.contains(musica.id)) {
      escolhidas.removeWhere((element) => element == musica.id);
      firestore.removerMusica(widget.playlist.id, musica);
    } else {
      escolhidas.add(musica.id);
      firestore.addMusica(widget.playlist.id, musica);
    }
  }
}
