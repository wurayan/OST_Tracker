import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String msg;
  const Empty({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(msg),
    );
  }
}
