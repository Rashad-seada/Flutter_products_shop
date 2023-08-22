import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eng_shop/core/bloc/core_cubit.dart';
import 'package:eng_shop/core/config/app_theme.dart';
import 'package:eng_shop/core/views/screens/intro_screen.dart';
import 'package:eng_shop/features/auth/views/bloc/auth_methods/auth_methods_cubit.dart';
import 'package:eng_shop/features/auth/views/bloc/registration/registration_cubit.dart';
import 'package:eng_shop/features/auth/views/bloc/reset_password/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'core/config/app_consts.dart';
import 'features/auth/views/bloc/login/login_cubit.dart';
import 'features/search/views/bloc/search/search_cubit.dart';
import 'features/shop/views/bloc/camera/camera_cubit.dart';
import 'features/shop/views/bloc/cart/cart_cubit.dart';
import 'features/shop/views/bloc/home/home_cubit.dart';
import 'features/shop/views/bloc/language/language_cubit.dart';
import 'features/shop/views/bloc/map/map_cubit.dart';
import 'features/shop/views/bloc/profile/profile_cubit.dart';
import 'features/shop/views/bloc/serivce_provider/service_provider_cubit.dart';
import 'generated/codegen_loader.g.dart';

void main() async {

  AppTheme.initSystemNavAndStatusBar();
  WidgetsFlutterBinding.ensureInitialized();

  await CoreCubit().init();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale(AppConsts.english),
          Locale(AppConsts.arabic)
        ],
        fallbackLocale: const Locale(AppConsts.english),
        path: AppConsts.localizationPath,
        assetLoader: const CodegenLoader(),
        child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Auth
        BlocProvider(create: (_)=> CoreCubit()),
        BlocProvider(create: (_)=> LoginCubit()),
        BlocProvider(create: (_)=> RegistrationCubit()),
        BlocProvider(create: (_)=> ResetPasswordCubit()),
        BlocProvider(create: (_)=> AuthMethodsCubit()),

        //main feature
        BlocProvider(create: (_)=> HomeCubit()),
        BlocProvider(create: (_)=> LanguageCubit()),
        BlocProvider(create: (_)=> ServiceProviderCubit()),
        BlocProvider(create: (_)=> ProfileCubit()),
        BlocProvider(create: (_)=> CameraCubit()),
        BlocProvider(create: (_)=> MapCubit()),
        BlocProvider(create: (_)=> CartCubit()),
        BlocProvider(create: (_)=> SearchCubit()),


      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return MaterialApp(

            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            home: const IntroScreen(),
          );
        },
      ),
    );
  }
}

//  dart run easy_localization:generate --source-dir assets/translations
//  dart run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart