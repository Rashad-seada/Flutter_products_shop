import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../../config/app_theme.dart';

class CustomProgressIndicator extends StatelessWidget {
  Color color;
  CustomProgressIndicator({super.key,this.color = AppTheme.primary900});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: LoadingAnimationWidget.flickr(
          leftDotColor: AppTheme.neutral100,
          rightDotColor: color,
          size: 10.w,
      ),
    );
  }
}
