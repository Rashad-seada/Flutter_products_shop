import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';


Future<void> showCustomDialog(BuildContext context,
    {String label = "",
    String message = "",
    String callToAction = "",
    String antiCallToAction = "",
      void Function()? onCallToActionTap,
      void Function()? onAntiCallToActionTap,
    }) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(label),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: onCallToActionTap,
            child: Text(callToAction,style: AppTheme.textL2TextStyle(),),
          ),

          TextButton(
            onPressed: onAntiCallToActionTap,
            child: Text(antiCallToAction,style: AppTheme.textL2TextStyle(color: AppTheme.primary900)),
          ),
        ],
      );
    },
  );
}
