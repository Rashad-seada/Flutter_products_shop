import 'dart:async';

import 'package:eng_shop/core/views/widgets/fade_in_animation.dart';
import 'package:eng_shop/features/auth/views/screens/auth_methods_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../bloc/core_cubit.dart';
import '../../config/app_images.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {

    context.read<CoreCubit>().getUserType(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<CoreCubit,CoreState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                body: Center(
                    child: FadeInAnimation(
                      child: Image.asset(
                        AppImages.logo,
                        width: 35.w,
                        height: 35.h,
                      ),
                    )
                )
            );
          },
        )
    );
  }
}
