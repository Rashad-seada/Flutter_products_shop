import 'package:animations/animations.dart';
import 'package:eng_shop/core/bloc/core_cubit.dart';
import 'package:eng_shop/core/views/screens/intro_screen.dart';
import 'package:eng_shop/features/auth/views/bloc/registration/registration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'features/auth/views/bloc/login/login_cubit.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  CoreCubit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> CoreCubit()),
        BlocProvider(create: (_)=> LoginCubit()),
        BlocProvider(create: (_)=> RegistrationCubit()),

      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.from(
              colorScheme: const ColorScheme.light(),
            ).copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: <TargetPlatform, PageTransitionsBuilder>{
                  TargetPlatform.android: SharedAxisPageTransitionsBuilder(transitionType: SharedAxisTransitionType.horizontal),
                  TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(transitionType: SharedAxisTransitionType.horizontal),
                },
              ),
            ),
            home: const IntroScreen(),
          );
        },
      ),
    );
  }
}
