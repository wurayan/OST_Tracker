import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';
import 'package:ost_tracker_og/decoration/theme.dart';

class Fab extends StatelessWidget {
  final String title;
  final Function function;
  const Fab(
      {super.key,
      required this.title,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [Shadows.shadowMid],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 3, color: ColorTheme.blackberry),
            color: ColorTheme.gojiberry),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: CustomTextTheme.fab,
            ),
          ],
        ),
      ),
    );
  }
}
