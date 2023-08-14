import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_theme.dart';

class AuthTextField extends StatelessWidget {
  TextEditingController? controller;
  String? hint;
  String? label;
  Widget? prefixIcon;
  Widget? suffixIcon;

  String? Function(String?)? validator;
  void Function()? onEditingComplete;
  ValueChanged<String>? onChanged;
  void Function(PointerDownEvent)? onTapOutside;
  bool enabled;

  AuthTextField({
    Key? key,
    this.controller,
    this.hint,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onEditingComplete,
    this.onChanged,
    this.onTapOutside,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

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
            borderSide: const BorderSide(color: AppTheme.neutral300,width: 1),
            borderRadius: BorderRadius.circular(8)
        ),

        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.neutral300,width: 1),
            borderRadius: BorderRadius.circular(8)
        ),

        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.primary900,width: 1),
            borderRadius: BorderRadius.circular(8)
        ),

        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.error,width: 1),
            borderRadius: BorderRadius.circular(8)
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