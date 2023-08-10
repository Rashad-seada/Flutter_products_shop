import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/views/widgets/fade_in_animation.dart';
import 'package:eng_shop/features/auth/views/screens/auth_methods_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../features/auth/views/screens/login_screen.dart';
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


    Timer.periodic(const Duration(seconds: 3), (timer) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => const AuthMethodsScreen()
          ), (route) => false
      );
    });
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
