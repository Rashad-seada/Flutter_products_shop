import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/config/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_consts.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../generated/locale_keys.g.dart';

class PhoneNumberField extends StatelessWidget {
  TextEditingController? controller;
  String? Function(String?)? validator;
  void Function(PhoneNumber)? onInputChanged;
  void Function(bool)? onInputValidated;
  Function(PointerDownEvent)? onTapOutside;
  Widget? suffixIcon;
  PhoneNumber initialValue ;

  bool enabled;

  PhoneNumberField({super.key, this.controller,this.validator,this.onInputChanged,this.onInputValidated,this.onTapOutside,this.suffixIcon,required this.initialValue,this.enabled = true});


  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      validator: validator,
      onInputChanged: onInputChanged,
      onInputValidated: onInputValidated,
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      inputBorder: const OutlineInputBorder(),
      inputDecoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        suffixIcon: suffixIcon,
        // Adjust the vertical padding as needed

        hintText: LocaleKeys.phone_number_hint.tr(),
        labelText: LocaleKeys.phone_number.tr(),

        labelStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppTheme.font16.sp,
          fontWeight: FontWeight.w400,
        ),

        hintStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppTheme.font16.sp,
          fontWeight: FontWeight.w400,
        ),


        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.neutral300, width: 1),
            borderRadius: BorderRadius.circular(8)
        ),

        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.primary900, width: 1),
            borderRadius: BorderRadius.circular(8)),

        // errorBorder: OutlineInputBorder(
        //     borderSide: const BorderSide(color: AppTheme.error, width: 1),
        //     borderRadius: BorderRadius.circular(8)),

        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.error, width: 1),
            borderRadius: BorderRadius.circular(8)),
      ),
      searchBoxDecoration: InputDecoration(
        enabled: enabled,
        contentPadding: EdgeInsets.symmetric(vertical: 2.3.h, horizontal: 5.w),
        // Adjust the vertical padding as needed

        hintText: LocaleKeys.country_hint.tr(),
        labelText: LocaleKeys.country.tr(),

        labelStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppTheme.font16.sp,
          fontWeight: FontWeight.w400,
        ),

        hintStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppTheme.font16.sp,
          fontWeight: FontWeight.w400,
        ),

        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.neutral300, width: 1),
            borderRadius: BorderRadius.circular(8)),

        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.primary900, width: 1),
            borderRadius: BorderRadius.circular(8)),

        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.error, width: 1),
            borderRadius: BorderRadius.circular(8)),

        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.error, width: 1),
            borderRadius: BorderRadius.circular(8)),
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: const TextStyle(color: Colors.black),
      initialValue: initialValue,
      textFieldController: controller,
      formatInput: true,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },

    );
  }
}
