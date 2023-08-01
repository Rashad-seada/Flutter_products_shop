import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class FadeInAnimation extends StatelessWidget {
  Widget child;

  FadeInAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PlayAnimationBuilder plays animation once
    return PlayAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1), // 100.0 to 200.0
      duration: const Duration(seconds: 1), // for 1 second
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      onCompleted: () {
        //
      },
    );
  }
}