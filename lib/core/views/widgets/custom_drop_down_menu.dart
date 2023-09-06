import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDropDownButton extends StatelessWidget {
  String? value;
  String? hint;
  Function(String?)? onChanged;
  List<String>? items;

  CustomDropDownButton({super.key,this.value,this.onChanged,this.items,this.hint});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.h,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.w),
            borderSide: BorderSide(color: AppTheme.neutral300),
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.w),
            borderSide: BorderSide(color: AppTheme.neutral300),
          ), //
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.w),
            borderSide: BorderSide(color: AppTheme.neutral300),
          ),
        ),
        value: value,
        onChanged: onChanged,
        items: items?.map((e) => DropdownMenuItem(
          value: e,
          child: Text(e),

        )).toList(),
        borderRadius: BorderRadius.circular(2.w),
      ),
    );
  }
}
