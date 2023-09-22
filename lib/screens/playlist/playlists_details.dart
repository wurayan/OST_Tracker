import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/components/fab.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/playlist_model.dart';
import 'package:ost_tracker_og/screens/playlist/assets/playlist_musicas.dart';
import 'package:ost_tracker_og/screens/playlist/buscar_musicas.dart';

class PlaylistDetails extends StatelessWidget {
  final Playlist playlist;
  const PlaylistDetails({super.key, required this.playlist});
  // final MusicaCubit _musicas = MusicaCubit();
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
                builder: (context) => BuscarMusicas(playlist: playlist),
              ))),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 32, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.nome,
                    style: CustomTextTheme.title,
                  ),
                  Text(
                    playlist.descricao,
                    style: CustomTextTheme.subtitle,
                  ),
                ],
              ),
            ),
          ),
          PlaylistMusicas(
            musicas: playlist.idMusicas,
          )
        ],
      ),
    );
  }
}
