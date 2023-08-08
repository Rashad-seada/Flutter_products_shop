
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'app_consts.dart';

abstract class AppTheme {

  static TextStyle? heading1TextStyle({Color color = AppTheme.neutral900}) => TextStyle(color: color,fontSize: AppConsts.font32.sp,fontWeight: FontWeight.bold);
  static TextStyle? heading2TextStyle({Color color = AppTheme.neutral900}) => TextStyle(color: color,fontSize: AppConsts.font28.sp);
  static TextStyle? heading3TextStyle({Color color = AppTheme.neutral900}) => TextStyle(color: color,fontSize: AppConsts.font21.sp);

  static TextStyle? textLTextStyle({Color color = AppTheme.neutral500}) => TextStyle(color:color ,fontSize: AppConsts.font16.sp);
  static TextStyle? textMTextStyle({Color color = AppTheme.neutral500}) => TextStyle(color: color,fontSize: AppConsts.font14.sp);


  static const Color neutral900 = Color(0xff111827);
  static const Color neutral800 = Color(0xff1F2937);
  static const Color neutral700 = Color(0xff374151);
  static const Color neutral600 = Color(0xff4B5563);
  static const Color neutral500 = Color(0xff6B7280);
  static const Color neutral400 = Color(0xff9CA3AF);
  static const Color neutral300 = Color(0xffD1D5DB);
  static const Color neutral200 = Color(0xffE5E7EB);
  static const Color neutral100 = Color(0xffF4F4F5);

  static const Color primary900 = Color(0xffC70000);
  static const Color primary800 = Color(0xffE61E29);
  static const Color primary700 = Color(0xffE93842);
  static const Color primary600 = Color(0xffEB5058);
  static const Color primary500 = Color(0xffED6A70);
  static const Color primary400 = Color(0xffF18289);
  static const Color primary300 = Color(0xffF49BA1);
  static const Color primary200 = Color(0xffF6B4B8);
  static const Color primary100 = Color(0xffF9CCCF);

  static const Color success = Color(0xff60c631);
  static const Color error = Color(0xffff472b);

}