import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_theme.dart';

class SearchField extends StatelessWidget {

  TextEditingController? controller;
  String? hint;
  String? label;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  void Function()? onEditingComplete;
  ValueChanged<String>? onChanged;
  void Function(PointerDownEvent)? onTapOutside;
  void Function()? onTap;
  void Function(String)? onFieldSubmitted;
  bool enabled;
  FocusNode? focusNode;

  SearchField({
    Key? key,
    this.controller,
    this.hint,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onEditingComplete,
    this.onChanged,
    this.onTapOutside,
    this.onTap,
    this.onFieldSubmitted,
    this.enabled = true,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      enabled: enabled,
      onTapOutside: onTapOutside,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 1.8.h), // Adjust the vertical padding as needed

        hintText: hint,
        labelText: label,

        labelStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppTheme.font16.sp,
          fontWeight: FontWeight.w400,
        ),

        prefixIcon: prefixIcon,

        hintStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppTheme.font16.sp,
          fontWeight: FontWeight.w400,
        ),

        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.neutral400,width: 1),
            borderRadius: BorderRadius.circular(100.w)
        ),

        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.neutral400,width: 1),
            borderRadius: BorderRadius.circular(100.w)
        ),

        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.primary900,width: 1),
            borderRadius: BorderRadius.circular(100.w)
        ),

        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.error,width: 1),
            borderRadius: BorderRadius.circular(100.w)
        ),

        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.error,width: 1),
            borderRadius: BorderRadius.circular(8)
        ),
      ),
      onEditingComplete: onEditingComplete,
    );
  }
}
