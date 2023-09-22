import 'package:flutter/material.dart';

class LeadingAppbar extends StatelessWidget {
  const LeadingAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IconButton(
        icon: const Icon(
          Icons.menu,
          size: 32,
          color: Colors.black,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
    );
  }
}
