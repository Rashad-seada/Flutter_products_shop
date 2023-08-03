import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/config/app_consts.dart';
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

  AuthTextField({Key? key,this.controller, this.hint,this.label,this.prefixIcon,this.suffixIcon,this.validator,this.onEditingComplete,this.onChanged,this.onTapOutside}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: onTapOutside,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 2.3.h), // Adjust the vertical padding as needed

        hintText: hint,
        labelText: label,

        labelStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppConsts.font16.sp,
          fontWeight: FontWeight.w400,
        ),

        prefixIcon: prefixIcon,

        hintStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppConsts.font16.sp,
          fontWeight: FontWeight.w400,
        ),

        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.neutral300,width: 1),
            borderRadius: BorderRadius.circular(8)
        ),

        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.primary,width: 1),
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