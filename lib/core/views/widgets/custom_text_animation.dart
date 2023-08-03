import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';

class CustomAnimatedText extends StatelessWidget {
  String text;
  CustomAnimatedText({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(animatedTexts: [
      TypewriterAnimatedText(
        text,
        speed: Duration(milliseconds: 300),
        textStyle: AppTheme.heading2TextStyle()
      )
    ]);
  }
}
