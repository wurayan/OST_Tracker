import 'package:flutter/material.dart';
import 'package:ost_tracker_og/models/musica_model.dart';
import 'package:ost_tracker_og/screens/musica/assets/musica_card.dart';

class MusicaList extends StatelessWidget {
  final List<Musica> musicas;
  const MusicaList({super.key, required this.musicas});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 32, 12, 0),
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: musicas.length,
        itemBuilder: (context, index) => MusicaCard(musica: musicas[index]),
      ),
    );
  }
}
