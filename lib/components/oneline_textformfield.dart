import 'package:flutter/material.dart';
import 'package:ost_tracker_og/decoration/common.dart';
import 'package:ost_tracker_og/decoration/theme.dart';

class OnelineTextformfield extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? validator;
  const OnelineTextformfield(
      {super.key,
      required this.controller,
      this.hintText,
      this.onChanged,
      this.onFieldSubmitted,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      onChanged: (event) => onChanged != null ? onChanged!(event) : null,
      onFieldSubmitted: (value) =>
          onFieldSubmitted != null ? onFieldSubmitted!(value) : null,
      decoration: InputDecoration(
        enabledBorder: outline,
        focusedBorder: outline,
        errorBorder: error,
        focusedErrorBorder: error,
        hintText: hintText,
        hintStyle: CustomTextTheme.hintText,
        contentPadding: const EdgeInsets.all(16),
      ),
      style: CustomTextTheme.hintText.copyWith(color: ColorTheme.text),
      validator: (value) => validator != null ? validator!(value) : null,
    );
  }
}
