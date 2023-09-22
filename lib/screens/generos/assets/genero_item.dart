import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/screens/generos/assets/view_genero.dart';

class GeneroItem extends StatelessWidget {
  final Genero genero;
  final VoidCallback? callback;
  const GeneroItem({super.key, required this.genero, this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => ViewGenero(
          genero: genero,
        ),
      ).then((value) {
        if (callback != null) callback!();
      }),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorTheme.blackberry, width: 3),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(12),
        child: Text(
          genero.nome,
          style: CustomTextTheme.itemHeader,
        ),
      ),
    );
  }
}
