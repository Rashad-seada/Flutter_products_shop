import 'package:dio/dio.dart';
import 'package:eng_shop/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:eng_shop/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:eng_shop/features/auth/data/repo/auth_repo_impl.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_email_entity.dart';
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

  static void setupDependencies () {
    getIt

      //local data source
      ..registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl())
      ..registerSingleton<SettingsLocalDataSource>(SettingsLocalDataSourceImpl())

      //remote data source
      ..registerSingletonAsync<AuthRemoteDataSource>(() async => AuthRemoteDataSourceImpl(
          domain: await getIt<SettingsLocalDataSource>().getServiceProviderDomain(),
          serviceEmail: await getIt<SettingsLocalDataSource>().getServiceProviderEmail(),
          servicePassword: await getIt<SettingsLocalDataSource>().getServiceProviderPassword()))
      ..registerSingleton<ProfileRemoteDataSource>(ProfileRemoteDataSourceImpl())

      //repo
      ..registerSingleton<AuthRepo>(AuthRepoImpl())

      //use case
      ..registerSingleton<ActivateAccountBySmsUsecase>(ActivateAccountBySmsUsecase(repo: getIt<AuthRepo>()))
      ..registerSingleton<LoginUsecase>(LoginUsecase(repo: getIt<AuthRepo>()))
      ..registerSingleton<RegisterUsecase>(RegisterUsecase(repo: getIt<AuthRepo>()))
      ..registerSingleton<ResetPasswordUsecase>(ResetPasswordUsecase(repo: getIt<AuthRepo>()))
      ..registerSingleton<SendSmsUsecase>(SendSmsUsecase(repo: getIt<AuthRepo>()))
      ..registerSingleton<ValidateCodeUsecase>(ValidateCodeUsecase(repo: getIt<AuthRepo>()))
      ..registerSingleton<ValidateEmailUsecase>(ValidateEmailUsecase(repo: getIt<AuthRepo>()))
      ..registerSingleton<ValidatePhoneUsecase>(ValidatePhoneUsecase(repo: getIt<AuthRepo>()));
  }

}

