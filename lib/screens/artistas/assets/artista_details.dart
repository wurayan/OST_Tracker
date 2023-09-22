import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/dialog/view_dialog.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/artista_model.dart';
import 'package:ost_tracker_og/service/artista.dart';

class ArtistaDetails extends StatelessWidget {
  final Artista artista;
  const ArtistaDetails({super.key, required this.artista});

  @override
  Widget build(BuildContext context) {
    return ViewDialog(
        children: [
          Text(artista.nome,
          style: CustomTextTheme.title,)
        ],
        delete: () {
          ArtistaFirestore firestore = ArtistaFirestore();
          firestore.deleteArtista(artista);
        },
        edit: () {});
  }
}
