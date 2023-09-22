import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/dialog/view_dialog.dart';
import 'package:ost_tracker_og/decoration/theme.dart';
import 'package:ost_tracker_og/models/tag_model.dart';
import 'package:ost_tracker_og/service/tag.dart';

class TagDetails extends StatelessWidget {
  final Tag tag;
  TagDetails({super.key, required this.tag});
  final TagFirestore _tag = TagFirestore();

  @override
  Widget build(BuildContext context) {
    return ViewDialog(
      delete: () {
        _tag.deleteTag(tag).then((value) => Navigator.pop(context));
      },
      edit: () {
        // _tag.editTag(tag).then((value) => Navigator.pop(context));
        Navigator.pop(context);
      },
      children: [
        Text(
          "NOME TAG",
          style: CustomTextTheme.title,
        ),
        Text(
          "DESCRIÇAO",
          style: CustomTextTheme.subtitle,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        )
      ],
    );
  }
}
