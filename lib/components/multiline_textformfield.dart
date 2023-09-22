import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/common.dart';
import 'package:ost_tracker_og/decoration/theme.dart';

class MultilineTextformfield extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  const MultilineTextformfield(
      {super.key,
      required this.controller,
      this.hintText,
      this.onChanged,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged != null ? (value) => onChanged!(value) : null,
      onFieldSubmitted:
          onFieldSubmitted != null ? (value) => onFieldSubmitted!(value) : null,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      decoration: InputDecoration(
        enabledBorder: outline,
        focusedBorder: outline,
        hintText: hintText,
        hintStyle: CustomTextTheme.hintText.copyWith(fontSize: 16),
      ),
      style: const TextStyle(
        fontSize: 16,
      ),
      minLines: 4,
      maxLines: 4,
    );
  }
}
