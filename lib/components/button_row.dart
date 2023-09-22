import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/theme.dart';

class ButtonRow extends StatelessWidget {
  final Function function;
  const ButtonRow({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: height * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.32,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                "CANCELAR",
                style: CustomTextTheme.botoes,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.32,
            child: ElevatedButton(
              onPressed: () => function(),
              child: Text(
                "SALVAR",
                style: CustomTextTheme.botoes,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
