import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/dialog/confirmation_dialog.dart';
import 'package:ost_tracker_og/components/empty_screen.dart';
import 'package:ost_tracker_og/components/loading.dart';
import 'package:ost_tracker_og/cubit/musica_cubit.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/musica_model.dart';
import 'package:ost_tracker_og/screens/musica/assets/musica_card_mini.dart';
import 'package:ost_tracker_og/service/playlist.dart';

class PlaylistMusicas extends StatefulWidget {
  final List<String> musicas;
  final String playlistId;
  final MusicaCubit cubit;
  const PlaylistMusicas(
      {super.key, required this.musicas, required this.playlistId, required this.cubit});

  @override
  State<PlaylistMusicas> createState() => _PlaylistMusicasState();
}

class _PlaylistMusicasState extends State<PlaylistMusicas> {
  // final MusicaCubit _musicas = MusicaCubit();
  final PlaylistFirestore _playlist = PlaylistFirestore();

  getMusicas() {
    widget.cubit.getOnlyMusicas(widget.musicas);
  }

  @override
  void initState() {
    getMusicas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.cubit,
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
                    _playlist.removerMusica(widget.playlistId, musica);
                    widget.musicas.remove(musica.id);
                    getMusicas();
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
    );
  }
}
