import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/tag_model.dart';

class TagChip extends StatelessWidget {
  final Tag tag;
  final bool selected;
  const TagChip({super.key, required this.tag, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Chip(
        label: Text(
          tag.nome,
          style: CustomTextTheme.chips.copyWith(
              color: selected ? ColorTheme.blackberry : ColorTheme.white),
        ),
        backgroundColor: selected ? ColorTheme.disable : ColorTheme.gojiberry,
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),

      // Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(25),
      //     color: Colors.indigo[400],
      //   ),
      //   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      //   child: const Text(
      //     "TAG",
      //     style: TextStyle(
      //         fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      // ),
    );
  }
}
