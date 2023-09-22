import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/button_row.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';

class ConfirmationDialog extends StatelessWidget {
  final Widget title;
  const ConfirmationDialog({super.key, required this.title});

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
          children: [
            title,
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ButtonRow(
                function: () => Navigator.pop(context, true),
                avancar: "SIM",
                voltar: "NÃO",
              ),
            )
          ],
        ),
      ),
    );
  }
}
