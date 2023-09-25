import 'package:flutter/material.dart';

class OverflowChipItens extends StatelessWidget {
  final Widget overflow;
  final double width;
  final List<Widget> children;
  const OverflowChipItens({
    super.key,
    required this.overflow,
    required this.width,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      width: width,
      child: CustomMultiChildLayout(
        delegate: MyDelegate(children.length),
        children: [..._list(), LayoutId(id: "overflow", child: overflow)],
      ),
    );
  }

  List<LayoutId> _list() {
    List<LayoutId> res = [];
    for (int i = 0; i < children.length; i++) {
      res.add(LayoutId(id: i, child: children[i]));
    }
    return res;
  }
}

class MyDelegate extends MultiChildLayoutDelegate {
  final int _childrenCount;

  MyDelegate(this._childrenCount);

  @override
  void performLayout(Size size) {
    // Get the size of the overflow item.
    // ignore: unused_local_variable
    final Size overflowSize = layoutChild(
      'overflow',
      BoxConstraints.loose(size),
    );
    // Get sizes of all children.
    final List<Size> childrenSizes = [
      for (int i = 0; i < _childrenCount; i++)
        layoutChild(i, BoxConstraints.loose(size)),
    ];
    // Hide everything for now.
    positionChild('overflow', const Offset(0, -2000));
    for (int i = 0; i < _childrenCount; i++) {
      positionChild(i, const Offset(0, -2000));
    }

    // Carefully position each child until we run out of space.
    Offset offset = Offset.zero;
    for (int i = 0; i < _childrenCount; i++) {
      if (offset.dx + childrenSizes[i].width + 30 < size.width) {
        positionChild(i, offset);
        offset += Offset(childrenSizes[i].width, 0);
      } else {
        positionChild('overflow', offset);
        offset = const Offset(0, 200);
        break;
      }
    }
  }

  @override
  bool shouldRelayout(oldDelegate) => true;
}
