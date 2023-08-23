import 'package:eng_shop/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class PullToRefresh extends StatelessWidget {
  Future<void> Function() onRefresh;
  Widget child;
  PullToRefresh({super.key,required this.child,required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      borderWidth: 5.0,
      color: AppTheme.primary900,
      springAnimationDurationInMilliseconds: 200,
      showChildOpacityTransition: false,
      onRefresh: onRefresh,	// refresh callback
      child: child,		// scroll view
    );
  }
}
