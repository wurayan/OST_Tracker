import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/musica_model.dart';
import 'package:ost_tracker_og/screens/musica/musica_details.dart';
import 'package:ost_tracker_og/utils/utils.dart';

class MusicaCard extends StatelessWidget {
  final Musica musica;
  const MusicaCard({super.key, required this.musica});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MusicaDetails(
            musica: musica,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          height: height * 0.175,
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
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    musica.artista,
                    style: CustomTextTheme.musicaCardSecondary,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: RichText(
                      text: TextSpan(
                          children: [...generoBuilder(musica.generos)]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  RichText(
                    text:
                        TextSpan(children: [...tagBuilder(musica.tags ?? [])]),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
