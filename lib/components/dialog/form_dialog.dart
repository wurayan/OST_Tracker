import 'package:flutter/material.dart';
import 'package:ost_tracker_og/components/button_row.dart';
import 'package:ost_tracker_og/decoration/shadows.dart';

class FormDialog extends StatelessWidget {
  final List<Widget> children;
  final Function save;
  final GlobalKey<FormState> formKey;
  const FormDialog({super.key, required this.children, required this.save, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    // final double height = MediaQuery.sizeOf(context).height;
    return Dialog(
      child: Container(
        // height: height * 0.5,
        width: width * 0.9,
        decoration: BoxDecoration(
            boxShadow: const [Shadows.shadowBig],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 3,
              color: Colors.black,
            ),
            color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...children,
              // const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ButtonRow(function: () => save(context)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
