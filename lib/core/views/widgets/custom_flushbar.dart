

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/app_theme.dart';

CustomFlushBar({required String title,required String message,required BuildContext context}){

  Flushbar(
    flushbarStyle : FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: AppTheme.neutral900,
    title: title,
    message: message,
    duration: const Duration(seconds: 3),
  ).show(context);

  //
}