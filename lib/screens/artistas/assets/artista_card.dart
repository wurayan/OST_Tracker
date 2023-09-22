import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/artista_model.dart';
import 'package:ost_tracker_og/screens/artistas/assets/artista_details.dart';
import 'package:ost_tracker_og/utils/utils.dart';

class ArtistaCard extends StatelessWidget {
  final Artista artista;
  const ArtistaCard({super.key, required this.artista});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () {},
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => ArtistaDetails(artista: artista),
        );
      },
      child: Container(
        height: height * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 3,
            color: ColorTheme.blackberry,
          ),
          boxShadow: const [Shadows.shadowMid],
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Column(
          children: [
            Text(
              artista.nome,
              style: CustomTextTheme.playlistCardHeader,
            ),
            RichText(
              text: TextSpan(children: [...generoBuilder(artista.generos)]),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
