import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';

class ViewDialog extends StatelessWidget {
  final List<Widget> children;
  final Function delete;
  final Function edit;
  const ViewDialog({super.key, required this.children, required this.delete, required this.edit});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Dialog(
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
            boxShadow: const [Shadows.shadowBig],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 3, color: Colors.black),
            color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...children,
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => delete(),
                    child: SizedBox(
                      width: 40,
                      child: Image.asset("assets/icons/eraser.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SizedBox(
                      width: 60,
                      child: Image.asset("assets/icons/cancel.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => edit(),
                    child: SizedBox(
                      width: 40,
                      child: Image.asset("assets/icons/edit.png"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
