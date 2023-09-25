import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/overflow_Chip_Itens.dart';
import 'package:ost_tracker_og/components/tag_chip.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/musica_model.dart';
import 'package:ost_tracker_og/models/tag_model.dart';
import 'package:ost_tracker_og/screens/musica/musica_details.dart';
import 'package:ost_tracker_og/utils/utils.dart';

class MusicaCardMini extends StatelessWidget {
  final Musica musica;
  final Function? navigator;
  final Function? delete;
  const MusicaCardMini({
    super.key,
    required this.musica,
    this.navigator,
    this.delete,
  });

  _details(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusicaDetails(musica: musica),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () => navigator == null ? _details(context) : navigator!(),
      onLongPress: () => delete != null ? delete!() : () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          height: height * 0.14,
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: const [Shadows.shadowMid],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 3, color: Colors.black),
              color: Colors.white),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  width: width * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 3, color: Colors.black),
                      color: Colors.amber),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    musica.nome.toUpperCase(),
                    style: CustomTextTheme.musicaCardHeader,
                  ),
                  Text(musica.artista,
                      style: CustomTextTheme.musicaCardSecondary),
                  Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Row(children: [
                        OverflowChipItens(
                            overflow: TagChip(tag: Tag.tagEllipsis),
                            width: width * 0.6,
                            children: [...tagBuilderWidget(musica.tags ?? [])])
                      ]))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
