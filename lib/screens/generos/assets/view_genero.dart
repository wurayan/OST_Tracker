import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/dialog/view_dialog.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/service/genero.dart';

class ViewGenero extends StatelessWidget {
  final Genero genero;
  ViewGenero({super.key, required this.genero});
  final GeneroFirestore _genero = GeneroFirestore();

  @override
  Widget build(BuildContext context) {
    return ViewDialog(
      delete: () {
        _genero.deleteGenero(genero).then((value) => Navigator.pop(context));
      },
      edit: () {
        _genero.editGenero(genero).then((value) => Navigator.pop(context));
      },
      children: [
        Text(
          genero.nome,
          style: CustomTextTheme.title,
        ),
      ],
    );
  }
}
