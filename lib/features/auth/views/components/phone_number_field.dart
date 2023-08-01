import 'package:eng_shop/core/config/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_consts.dart';
import '../../../../core/config/app_theme.dart';

class PhoneNumberField extends StatelessWidget {
  TextEditingController? controller;
  String? Function(String?)? validator;
  void Function(PhoneNumber)? onInputChanged;
  void Function(bool)? onInputValidated;

  PhoneNumberField({super.key, this.controller,this.validator,this.onInputChanged,this.onInputValidated});

  PhoneNumber number = PhoneNumber(isoCode: 'KW');

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
        contentPadding: EdgeInsets.symmetric(vertical: 2.3.h, horizontal: 5.w),
        // Adjust the vertical padding as needed

        hintText: AppStrings.phoneNumberHint,
        labelText: AppStrings.phoneNumber,

        labelStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppConsts.font16.sp,
          fontWeight: FontWeight.w400,
        ),

        hintStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppConsts.font16.sp,
          fontWeight: FontWeight.w400,
        ),

        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.neutral300, width: 1),
            borderRadius: BorderRadius.circular(8)),

        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.primary, width: 1),
            borderRadius: BorderRadius.circular(8)),

        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.error, width: 1),
            borderRadius: BorderRadius.circular(8)),

        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.error, width: 1),
            borderRadius: BorderRadius.circular(8)),
      ),
      searchBoxDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 2.3.h, horizontal: 5.w),
        // Adjust the vertical padding as needed

        hintText: AppStrings.countryHint,
        labelText: AppStrings.country,

        labelStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppConsts.font16.sp,
          fontWeight: FontWeight.w400,
        ),

        hintStyle: TextStyle(
          color: AppTheme.neutral400,
          fontSize: AppConsts.font16.sp,
          fontWeight: FontWeight.w400,
        ),

        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.neutral300, width: 1),
            borderRadius: BorderRadius.circular(8)),

        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppTheme.primary, width: 1),
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
      initialValue: number,
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
