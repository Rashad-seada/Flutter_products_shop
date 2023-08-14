import 'dart:async';
import 'dart:async';

import 'package:eng_shop/core/services/camera_service.dart';
import 'package:eng_shop/core/services/google_service.dart';
import 'package:eng_shop/core/services/network_service.dart';
import 'package:eng_shop/core/services/permission_service.dart';
import 'package:eng_shop/core/services/services.dart';
import 'package:eng_shop/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:eng_shop/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:eng_shop/features/auth/data/repo/auth_repo_impl.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';
import 'package:eng_shop/features/auth/domain/usecase/activate_account_by_sms.dart';
import 'package:eng_shop/features/auth/domain/usecase/login_uscase.dart';
import 'package:eng_shop/features/auth/domain/usecase/register_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/send_sms_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_code_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_email_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_phone_usecase.dart';
import 'package:eng_shop/features/main_feature/data/data_source/local_data_source/settings_local_data_source.dart';
import 'package:eng_shop/features/main_feature/data/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;


class AppModule {

    static Future<void> setupDependencies() async {
        // Register synchronous dependencies
        getIt
            ..registerSingleton<CameraService>(CameraService())
            ..registerSingleton<GoogleService>(GoogleService())
            ..registerSingleton<NetworkService>(NetworkServiceImpl())
            ..registerSingleton<PermissionService>(PermissionService())
            ..registerSingleton<Services>(Services())
            ..registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl())
            ..registerSingleton<SettingsLocalDataSource>(SettingsLocalDataSourceImpl())
            ..registerSingleton<ProfileRemoteDataSource>(ProfileRemoteDataSourceImpl());

        // Initialize and register AuthRemoteDataSource asynchronously
        final authRemoteDataSource = await _initializeAuthRemoteDataSource();
        getIt.registerSingleton<AuthRemoteDataSource>(authRemoteDataSource);

        // Register the rest of the dependencies that depend on AuthRepo
        getIt
            ..registerSingleton<AuthRepo>(AuthRepoImpl(
                localDataSource: getIt<AuthLocalDataSource>(),
                settingsLocalDataSource: getIt<SettingsLocalDataSource>(),
                services: getIt<Services>(),
                remoteDataSource: getIt<AuthRemoteDataSource>()))
            ..registerSingleton<ActivateAccountBySmsUsecase>(
                ActivateAccountBySmsUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<LoginUsecase>(LoginUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<RegisterUsecase>(RegisterUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<ResetPasswordUsecase>(
                ResetPasswordUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<SendSmsUsecase>(SendSmsUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<ValidateCodeUsecase>(
                ValidateCodeUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<ValidateEmailUsecase>(
                ValidateEmailUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<ValidatePhoneUsecase>(
                ValidatePhoneUsecase(repo: getIt<AuthRepo>()));
    }

    static Future<AuthRemoteDataSource> _initializeAuthRemoteDataSource() async {
        return AuthRemoteDataSourceImpl(
            domain: await getIt<SettingsLocalDataSource>().getServiceProviderDomain(),
            serviceEmail: await getIt<SettingsLocalDataSource>().getServiceProviderEmail(),
            servicePassword: await getIt<SettingsLocalDataSource>().getServiceProviderPassword(),
        );
    }

}

