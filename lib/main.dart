import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/bloc/core_cubit.dart';
import 'package:eng_shop/core/views/screens/intro_screen.dart';
import 'package:eng_shop/features/auth/views/bloc/registration/registration_cubit.dart';
import 'package:eng_shop/features/auth/views/bloc/reset_password/reset_password_cubit.dart';
import 'package:eng_shop/translations/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'core/config/app_consts.dart';
import 'features/auth/views/bloc/login/login_cubit.dart';

void main() async {

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  await CoreCubit.init();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale("en"),
          Locale("ar")
        ],
        path: AppConsts.localizationPath,
        child: const MyApp(),
        assetLoader: CodegenLoader()
    )
  );
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
        BlocProvider(create: (_)=> ResetPasswordCubit()),

      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
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
