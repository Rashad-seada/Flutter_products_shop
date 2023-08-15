import 'dart:async';

import 'package:eng_shop/core/services/camera_service.dart';
import 'package:eng_shop/core/services/google_service.dart';
import 'package:eng_shop/core/services/location_service.dart';
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
import 'package:eng_shop/features/auth/domain/usecase/reset_password_by_email_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/reset_password_by_sms_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/send_sms_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_code_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_email_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_phone_usecase.dart';
import 'package:eng_shop/features/main_feature/data/data_source/local_data_source/product_local_data_source.dart';
import 'package:eng_shop/features/main_feature/data/data_source/local_data_source/settings_local_data_source.dart';
import 'package:eng_shop/features/main_feature/data/data_source/remote_data_source/product_remote_data_source.dart';
import 'package:eng_shop/features/main_feature/data/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:eng_shop/features/main_feature/data/repo/product_repo_impl.dart';
import 'package:eng_shop/features/main_feature/domain/repo/product_repo.dart';
import 'package:eng_shop/features/main_feature/domain/usecase/add_to_cart_usecase.dart';
import 'package:eng_shop/features/main_feature/domain/usecase/get_cart_usecase.dart';
import 'package:eng_shop/features/main_feature/domain/usecase/get_image_by_id_usecase.dart';
import 'package:eng_shop/features/main_feature/domain/usecase/get_product_by_id_usecase.dart';
import 'package:eng_shop/features/main_feature/domain/usecase/get_products_usecase.dart';
import 'package:eng_shop/features/main_feature/domain/usecase/remove_from_cart_usecase.dart';
import 'package:eng_shop/features/main_feature/domain/usecase/search_usecase.dart';
import 'package:get_it/get_it.dart';

import '../../features/main_feature/data/data_source/local_data_source/database/database.dart';
import '../config/app_consts.dart';

final GetIt getIt = GetIt.instance;


class AppModule {

    static Future<void> setupDependencies() async {
        // Register synchronous dependencies
        getIt

            //services
            ..registerSingleton<CameraService>(CameraService())
            ..registerSingleton<GoogleService>(GoogleService())
            ..registerSingleton<NetworkService>(NetworkServiceImpl())
            ..registerSingleton<PermissionService>(PermissionService())
            ..registerSingleton<LocationService>(LocationService())
            ..registerSingleton<Services>(Services())


            //Local data source
            ..registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl())
            ..registerSingleton<SettingsLocalDataSource>(SettingsLocalDataSourceImpl());

            final database = await _initializeProductsDatabase();
            getIt
            ..registerSingleton<ProductLocalDataSource>(ProductLocalDataSourceImpl(database))


             //Remote data source
            ..registerSingleton<ProfileRemoteDataSource>(ProfileRemoteDataSourceImpl());

            final authRemoteDataSource = await _initializeAuthRemoteDataSource();
            getIt.registerSingleton<AuthRemoteDataSource>(authRemoteDataSource);

            final productRemoteDataSource = await _initializeProductRemoteDataSource();
            getIt.registerSingleton<ProductRemoteDataSource>(productRemoteDataSource);

            //Repos
        getIt
            ..registerSingleton<AuthRepo>(AuthRepoImpl(
                localDataSource: getIt<AuthLocalDataSource>(),
                settingsLocalDataSource: getIt<SettingsLocalDataSource>(),
                services: getIt<Services>(),
                remoteDataSource: getIt<AuthRemoteDataSource>()))
            ..registerSingleton<ProductRepo>(ProductRepoImpl(
                remoteDataSource: getIt<ProductRemoteDataSource>(),
                localDataSource: getIt<ProductLocalDataSource>(),
                settingsLocalDataSource: getIt<SettingsLocalDataSource>(),
                services: getIt<Services>()))

            //Use cases
            ..registerSingleton<ActivateAccountBySmsUsecase>(
                ActivateAccountBySmsUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<LoginUsecase>(LoginUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<RegisterUsecase>(RegisterUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<ResetPasswordBySMSUsecase>(
                ResetPasswordBySMSUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<SendSmsUsecase>(SendSmsUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<ValidateCodeUsecase>(
                ValidateCodeUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<ValidateEmailUsecase>(
                ValidateEmailUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<ValidatePhoneUsecase>(
                ValidatePhoneUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<ResetPasswordByEmailUsecase>(
                ResetPasswordByEmailUsecase(repo: getIt<AuthRepo>()))

            ..registerSingleton<AddToCartUsecase>(
                AddToCartUsecase(repo: getIt<ProductRepo>()))
            ..registerSingleton<GetCartUsecase>(
                GetCartUsecase(repo: getIt<ProductRepo>()))
            ..registerSingleton<GetImageByIdUsecase>(
                GetImageByIdUsecase(repo: getIt<ProductRepo>()))
            ..registerSingleton<GetProductByIdUsecase>(
                GetProductByIdUsecase(repo: getIt<ProductRepo>()))
            ..registerSingleton<GetProductsUsecase>(
                GetProductsUsecase(repo: getIt<ProductRepo>()))
            ..registerSingleton<RemoveFromCartUsecase>(
                RemoveFromCartUsecase(repo: getIt<ProductRepo>()))
            ..registerSingleton<SearchUsecase>(
                SearchUsecase(repo: getIt<ProductRepo>()));
    }

    static Future<AuthRemoteDataSource> _initializeAuthRemoteDataSource() async {
        return AuthRemoteDataSourceImpl(
            domain: await getIt<SettingsLocalDataSource>().getServiceProviderDomain(),
            serviceEmail: await getIt<SettingsLocalDataSource>().getServiceProviderEmail(),
            servicePassword: await getIt<SettingsLocalDataSource>().getServiceProviderPassword(),
        );
    }

    static Future<ProductRemoteDataSource> _initializeProductRemoteDataSource() async {
        return ProductRemoteDataSourceImpl(
            domain: await getIt<SettingsLocalDataSource>().getServiceProviderDomain(),
            serviceEmail: await getIt<SettingsLocalDataSource>().getServiceProviderEmail(),
            servicePassword: await getIt<SettingsLocalDataSource>().getServiceProviderPassword(),
        );
    }

    static Future<AppDatabase> _initializeProductsDatabase() async {
        return await $FloorAppDatabase.databaseBuilder(AppConsts.mainDBName).build();

    }

}

