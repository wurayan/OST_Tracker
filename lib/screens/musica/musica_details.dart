import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/appbar/appbar_custom.dart';
import 'package:ost_tracker_og/components/drawer/drawer_custom.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/musica_model.dart';
import 'package:ost_tracker_og/utils/utils.dart';

class MusicaDetails extends StatelessWidget {
  final Musica musica;
  const MusicaDetails({super.key, required this.musica});

  @override
  Widget build(BuildContext context) {
    // final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: const AppbarCustom(
        title: "",
        activeSearch: false,
      ),
      drawer: const DrawerCustom(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: height * 0.3,
              color: ColorTheme.blackberry,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      musica.nome,
                      style: CustomTextTheme.title,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: Image.asset("assets/icons/edit.png"),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                musica.artista,
                style: CustomTextTheme.subtitle,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
              child: Text(
                "\"${musica.anotacoes}\"",
                style: CustomTextTheme.subtitle,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: RichText(
                text: TextSpan(
                  children: [...generoBuilder(musica.generos)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: RichText(
                text: TextSpan(
                  children: [...tagBuilder(musica.tags ?? [])],
                ),
                maxLines: 2,
                softWrap: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "link de coisa . com",
                style: CustomTextTheme.itemHeader,
              ),
            )
          ],
        ),
      ),
    );
  }
}
