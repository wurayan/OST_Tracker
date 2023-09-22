import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/dialog/confirmation_dialog.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/components/empty_screen.dart';
import 'package:ost_tracker_og/components/fab.dart';
import 'package:ost_tracker_og/components/loading.dart';
import 'package:ost_tracker_og/cubit/musica_cubit.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/musica_model.dart';
import 'package:ost_tracker_og/models/playlist_model.dart';
import 'package:ost_tracker_og/screens/musica/assets/musica_card_mini.dart';
import 'package:ost_tracker_og/screens/playlist/buscar_musicas.dart';
import 'package:ost_tracker_og/service/playlist.dart';

class PlaylistDetails extends StatefulWidget {
  final Playlist playlist;
  const PlaylistDetails({super.key, required this.playlist});

  @override
  State<PlaylistDetails> createState() => _PlaylistDetailsState();
}

class _PlaylistDetailsState extends State<PlaylistDetails> {
  final MusicaCubit _musicas = MusicaCubit();
  final PlaylistFirestore _playlist = PlaylistFirestore();

  @override
  void initState() {
    _musicas.getOnlyMusicas(widget.playlist.idMusicas);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCustom(title: "", activeSearch: true),
      drawer: const DrawerCustom(),
      floatingActionButton: Fab(
          title: "ADD MÚSICA",
          function: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BuscarMusicas(playlist: widget.playlist),
                  )).then((value) {
                if (value == null) return;
                _musicas.getOnlyMusicas(value);
              })),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 32, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.playlist.nome,
                    style: CustomTextTheme.title,
                  ),
                  Text(
                    widget.playlist.descricao,
                    style: CustomTextTheme.subtitle,
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder(
            bloc: _musicas,
            builder: (context, state) {
              if (state is MusicaLoading) {
                return const SliverToBoxAdapter(child: Loading());
              } else if (state is MusicaSuccess) {
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 32, 12, 0),
                  sliver: SliverList.builder(
                    addAutomaticKeepAlives: true,
                    itemCount: state.musicas.length,
                    itemBuilder: (context, index) {
                      Musica musica = state.musicas[index];
                      return MusicaCardMini(
                        musica: musica,
                        delete: () async {
                          bool? confirmation = await showDialog(
                              context: context,
                              builder: (context) => ConfirmationDialog(
                                  title: Text("Remover música da Playlist?",
                                      style: CustomTextTheme.subtitle)));
                          if (confirmation != true) return;
                          _playlist.removerMusica(widget.playlist.id, musica);
                          widget.playlist.idMusicas.remove(musica.id);
                          _musicas.getOnlyMusicas(widget.playlist.idMusicas);
                        },
                      );
                    },
                  ),
                );
              } else if (state is MusicaEmpty) {
                return SliverToBoxAdapter(child: Empty(msg: state.msg));
              } else if (state is MusicaError) {
                return SliverToBoxAdapter(child: Empty(msg: state.error));
              } else {
                return const SliverToBoxAdapter();
              }
            },
          )
        ],
      ),
    );
  }
}
