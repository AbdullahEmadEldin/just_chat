import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors/colors_manager.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final Color? backgroundColor;
  final Widget? suffixIcon;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final bool? obscureText;
  final bool readOnly;
  final TextEditingController? controller;
  final int? maxLines;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  const InputField({
    super.key,
    required this.hintText,
    this.contentPadding,
    this.validator,
    this.backgroundColor,
    this.suffixIcon,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.obscureText,
    this.readOnly = false,
    this.controller,
    this.maxLines,
    this.onChanged,
    this.onSaved,
    this.focusNode,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines,
      controller: controller,
      readOnly: readOnly,
      validator: validator,
      obscureText: obscureText ?? false,
      style: textStyle ??
          Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorsManager().colorScheme.grey80,
              ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: ColorsManager().colorScheme.grey60),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: backgroundColor ??
            ColorsManager().colorScheme.grey20.withOpacity(0.4),
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 18.h,
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: ColorsManager().colorScheme.grey40,
                width: 1.3,
              ),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: ColorsManager().colorScheme.primary,
                width: 1.3,
              ),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: ColorsManager().colorScheme.fillRed,
                width: 1.3,
              ),
            ),
        focusedErrorBorder: errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: ColorsManager().colorScheme.fillRed,
                width: 1.3,
              ),
            ),
      ),
    );
  }
}
