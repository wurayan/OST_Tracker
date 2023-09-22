import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/genero_model.dart';

class GeneroChip extends StatelessWidget {
  final Genero genero;
  final bool selected;
  const GeneroChip({super.key, required this.genero, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Chip(
        label: Text(
          genero.nome,
          style: CustomTextTheme.chips.copyWith(
              color: selected ? ColorTheme.gojiberry : ColorTheme.text),
        ),
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Colors.transparent,
        side: BorderSide(color: ColorTheme.blackberry, width: 3),
        labelPadding: const EdgeInsets.symmetric(vertical: -2, horizontal: 4),
      ),
    );
  }
}
