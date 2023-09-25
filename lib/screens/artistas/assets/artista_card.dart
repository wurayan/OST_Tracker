import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/genero_chip.dart';
import 'package:ost_tracker_og/components/overflow_Chip_Itens.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/artista_model.dart';
import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/screens/artistas/assets/artista_details.dart';
import 'package:ost_tracker_og/utils/utils.dart';

class ArtistaCard extends StatelessWidget {
  final Artista artista;
  const ArtistaCard({super.key, required this.artista});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {},
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => ArtistaDetails(artista: artista),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          height: height * 0.13,
          width: width,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                artista.nome,
                style: CustomTextTheme.playlistCardHeader,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  child: OverflowChipItens(
                      overflow: GeneroChip(genero: Genero.generoEllipsis),
                      width: width * 0.9,
                      children: [...generoBuilderWidget(artista.generos)]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
