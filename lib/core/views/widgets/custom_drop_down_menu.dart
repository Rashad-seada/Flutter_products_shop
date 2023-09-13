import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  T? value;
  String? hint;
  Function(T?)? onChanged;
  Widget? suffixIcon;
  List<DropdownMenuItem<T>>? items;
  BorderRadius borderRadius;

  CustomDropDownButton({
    super.key,
    this.value,
    this.onChanged,
    this.items = const [],
    this.hint,
    this.suffixIcon,
    this.borderRadius =  const BorderRadius.all(Radius.circular(100000)),

  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hint,
        contentPadding: const EdgeInsets.fromLTRB(12, 12, 8, 15), // Adjust padding as needed

        hintStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppTheme.font14.sp,
          fontWeight: FontWeight.w400,
        ),

        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.neutral400,width: 1),
            borderRadius: borderRadius
        ),

        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.neutral300,width: 1),
            borderRadius: borderRadius
        ),

        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.primary900,width: 1),
            borderRadius: borderRadius
        ),

        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.error,width: 1),
            borderRadius: borderRadius
        ),

        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.error,width: 1),
            borderRadius: borderRadius
        ),
      ),
      style: TextStyle(
        color: AppTheme.neutral900,
        fontSize: AppTheme.font14.sp,
        fontWeight: FontWeight.w400,
      ),

      value: value,

      onChanged: onChanged,
      items: items,
      borderRadius: BorderRadius.circular(2.w),
    );
  }
}


