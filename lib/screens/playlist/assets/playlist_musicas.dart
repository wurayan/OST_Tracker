import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ost_tracker_og/components/empty_screen.dart';
import 'package:ost_tracker_og/components/loading.dart';
import 'package:ost_tracker_og/cubit/musica_cubit.dart';
import 'package:ost_tracker_og/screens/musica/assets/musica_card_mini.dart';

class PlaylistMusicas extends StatefulWidget {
  final List<String> musicas;
  const PlaylistMusicas({super.key, required this.musicas});

  @override
  State<PlaylistMusicas> createState() => _PlaylistMusicasState();
}

class _PlaylistMusicasState extends State<PlaylistMusicas> {
  final MusicaCubit _musicas = MusicaCubit();

  getMusicas() {
    _musicas.getOnlyMusicas(widget.musicas);
  }

  @override
  void initState() {
    getMusicas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
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
              itemBuilder: (context, index) => MusicaCardMini(
                musica: state.musicas[index],
              ),
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
