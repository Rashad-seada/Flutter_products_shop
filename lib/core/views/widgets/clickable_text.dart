import 'package:eng_shop/core/views/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/app_theme.dart';

class ClickableText extends StatelessWidget {
  VoidCallback? onPressed;
  String clickableText;
  String text;
  TextStyle? style;
  ClickableText({Key? key,required this.clickableText, this.onPressed, this.style,this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,style: TextStyle(color: AppTheme.neutral500),),
        Space(width: (text.isEmpty)? 0 : .1.w,),
        TextButton(onPressed: onPressed, child: Text(clickableText,style: style,)),
      ],
    );
  }
}
