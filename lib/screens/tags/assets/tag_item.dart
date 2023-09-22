import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/tag_model.dart';
import 'package:ost_tracker_og/screens/tags/assets/tag_details.dart';
import 'package:ost_tracker_og/utils/utils.dart';

class TagItem extends StatelessWidget {
  final Tag tag;
  final VoidCallback? callback;
  const TagItem({super.key, required this.tag, this.callback});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => TagDetails(
          tag: tag,
        ),
      ).then((value) {
        if (callback != null) callback!();
      }),
      child: Container(
        width: _calcularWidth(width),
        height: height * 0.1,
        decoration: BoxDecoration(
            // color: Colors.cyan[200],
            border: Border.all(color: ColorTheme.blackberry, width: 3),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [Shadows.shadowSmall],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  getRandomColor(tagColors),
                  getRandomColor(tagColors)
                ])),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tag.nome,
              // "123456789012345678901234567890",
              style: CustomTextTheme.itemHeader,
            ),
            Text(
              tag.descricao,
              style: CustomTextTheme.itemSecondary,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            )
          ],
        ),
      ),
    );
  }

  double _calcularWidth(double width) {
    int length = tag.nome.length;
    double letterWidth = (width / 34);
    if (length < 5) return letterWidth * 10;
    return length < 22 ? letterWidth * length * 1.5 : letterWidth * length;
  }
}
