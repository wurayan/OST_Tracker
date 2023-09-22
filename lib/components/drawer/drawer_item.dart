import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/theme.dart';

class DrawerItem extends StatefulWidget {
  final String title;
  final Function function;
  const DrawerItem({super.key, required this.title, required this.function});

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.04),
      child: GestureDetector(
        onTap: () => widget.function(),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 2, color: Colors.black),
            ),
          ),
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            widget.title,
            style: CustomTextTheme.drawerItem,
          ),
        ),
      ),
    );
  }
}
