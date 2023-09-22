import 'package:flutter/material.dart';
import 'package:ost_tracker_og/models/playlist_model.dart';
import 'package:ost_tracker_og/screens/playlist/assets/playlist_card.dart';

class PlaylistList extends StatelessWidget {
  final List<Playlist> playlists;
  const PlaylistList({super.key, required this.playlists});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12,32,12,0),
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: playlists.length,
        itemBuilder: (context, index) => PlaylistCard(playlist: playlists[index]),
        ),
    );
  }
}
