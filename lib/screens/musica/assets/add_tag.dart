import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/dialog/add_tag_dialog.dart';
import 'package:ost_tracker_og/components/tag_chip.dart';
import 'package:ost_tracker_og/models/tag_model.dart';

class TagList extends StatefulWidget {
  final List<Tag> tags;
  const TagList({super.key, required this.tags});

  @override
  State<TagList> createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  List<Tag> tags = [];

  @override
  void initState() {
    tags = widget.tags;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length+1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
                onTap: () => showDialog(
                      context: context,
                      builder: (context) => AddTagDialog(tags: tags),
                    ).then((value) {
                      if (value==true) setState(() {});
                    }),
                child: TagChip(
                  tag: Tag.addTag,
                ));
          } else {
            return TagChip(
              tag: tags[index-1],
            );
          }
        },
      ),
    );
  }
}
