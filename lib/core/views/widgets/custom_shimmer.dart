import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {

  Widget child;
  Color baseColor;
  Color highlightColor;

  CustomShimmer({super.key,this.baseColor = AppTheme.neutral100,this.highlightColor = AppTheme.neutral200,required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }
}
