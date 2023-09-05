import 'dart:async';

import 'package:eng_shop/core/infrastructure/api/api.dart';
import 'package:eng_shop/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:eng_shop/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:eng_shop/features/auth/data/repo/auth_repo_impl.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';
import 'package:eng_shop/features/auth/domain/usecase/activate_account_by_sms.dart';
import 'package:eng_shop/features/auth/domain/usecase/login_uscase.dart';
import 'package:eng_shop/features/auth/domain/usecase/logout_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/register_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/reset_password_by_email_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/reset_password_by_sms_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/send_sms_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_code_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_email_usecase.dart';
import 'package:eng_shop/features/auth/domain/usecase/validate_phone_usecase.dart';
import 'package:eng_shop/features/cart/data/data_source/local/cart_local_data_source.dart';
import 'package:eng_shop/features/cart/data/repo/cart_repo_impl.dart';
import 'package:eng_shop/features/cart/domain/repo/cart_repo.dart';
import 'package:eng_shop/features/cart/domain/usecase/clear_cart_usecase.dart';
import 'package:eng_shop/features/favorites/data/data_source/remote/favorite_remote_data_source.dart';
import 'package:eng_shop/features/favorites/data/repo/favorites_repo_impl.dart';
import 'package:eng_shop/features/favorites/domain/repo/favorites_repo.dart';
import 'package:eng_shop/features/favorites/domain/usecase/add_to_favorite_usecase.dart';
import 'package:eng_shop/features/favorites/domain/usecase/get_user_favorite_usecase.dart';
import 'package:eng_shop/features/favorites/domain/usecase/remove_from_favorite_usecase.dart';
import 'package:eng_shop/features/profile/domain/repo/profile_repo.dart';
import 'package:eng_shop/features/profile/data/repo/profile_repo_impl.dart';
import 'package:eng_shop/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:eng_shop/features/profile/domain/usecases/get_orders_by_state.dart';
import 'package:eng_shop/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:eng_shop/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:eng_shop/features/search/data/data_source/local_data_source/search_local_data_source.dart';
import 'package:eng_shop/features/search/data/data_source/remote_data_source/search_remote_data_source.dart';
import 'package:eng_shop/features/search/domain/repo/search_repo_impl.dart';
import 'package:eng_shop/features/search/domain/usecase/delete_all_recent_search_usecase.dart';
import 'package:eng_shop/features/search/domain/usecase/delete_recent_search_usecase.dart';
import 'package:eng_shop/features/search/domain/usecase/get_recent_search_usecase.dart';
import 'package:eng_shop/features/search/domain/usecase/insert_recent_search_usecase.dart';
import 'package:eng_shop/features/search/domain/usecase/search_usecase.dart';
import 'package:eng_shop/features/categories/data/repo/category_repo_impl.dart';
import 'package:eng_shop/features/categories/domain/repo/category_repo.dart';
import 'package:eng_shop/features/categories/domain/usecase/get_all_categories_usecase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/auth/domain/usecase/get_user_type_usecase.dart';
import '../../features/cart/domain/usecase/add_to_cart_usecase.dart';
import '../../features/cart/domain/usecase/get_cart_usecase.dart';
import '../../features/cart/domain/usecase/remove_from_cart_usecase.dart';
import '../../features/cart/domain/usecase/update_cart_usecase.dart';
import '../../features/categories/data/data_source/remote/category_remote_data_source.dart';
import '../../features/categories/domain/usecase/get_category_products_usecase.dart';
import '../../features/categories/domain/usecase/get_sub_categories_usecase.dart';
import '../../features/order/data/data_source/remote/order_remote_data_source.dart';
import '../../features/order/data/repo/order_repo_impl.dart';
import '../../features/order/domain/repo/order_repo.dart';
import '../../features/order/domain/usecase/make_order_items_usecase.dart';
import '../../features/order/domain/usecase/make_order_usecase.dart';
import '../../features/profile/data/data_source/remote/profile_remote_data_source.dart';
import '../../features/search/data/repo/search_repo.dart';
import '../../features/shop/data/data_source/local/product_local_data_source.dart';
import '../../features/settings/data/data_source/local/settings_local_data_source.dart';
import '../../features/shop/data/data_source/remote/product_remote_data_source.dart';
import '../../features/shop/data/repo/product_repo_impl.dart';
import '../../features/shop/domain/repo/product_repo.dart';
import '../../features/shop/domain/usecase/products/drop_all_products_usecase.dart';
import '../../features/shop/domain/usecase/products/get_image_by_id_usecase.dart';
import '../../features/shop/domain/usecase/products/get_product_by_id_usecase.dart';
import '../../features/shop/domain/usecase/products/get_products_usecase.dart';
import '../config/app_consts.dart';
import '../infrastructure/database/database.dart';
import '../infrastructure/services/camera_service.dart';
import '../infrastructure/services/google_service.dart';
import '../infrastructure/services/locale_service.dart';
import '../infrastructure/services/location_service.dart';
import '../infrastructure/services/network_service.dart';
import '../infrastructure/services/permission_service.dart';
import '../infrastructure/services/services.dart';

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
            ..registerSingleton<LocaleService>(LocaleService())
            ..registerSingleton<Services>(Services())
            ..registerSingleton<Api>(ApiImpl());


            //Local data source
            final hiveStorage = await _initializeHiveDatabase();
            getIt.registerSingleton<Box>(hiveStorage);

        getIt
            ..registerSingleton<FlutterSecureStorage>( FlutterSecureStorage())
            ..registerSingleton<SettingsLocalDataSource>(SettingsLocalDataSourceImpl(storage: getIt<Box>()))
            ..registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl(secureStorage: getIt<FlutterSecureStorage>(), storage: getIt<Box>()));


            await _seedingInitialValue();

            final database = await _initializeProductsDatabase();
            getIt
                ..registerSingleton<ProductLocalDataSource>(ProductLocalDataSourceImpl(database))
                ..registerSingleton<SearchLocalDataSource>(SearchLocalDataSourceImpl(database))
                ..registerSingleton<CartLocalDataSource>(CartLocalDataSourceImpl(database));


            //Remote data source

            final authRemoteDataSource = await _initializeAuthRemoteDataSource();
            getIt.registerSingleton<AuthRemoteDataSource>(authRemoteDataSource);

            final productRemoteDataSource = await _initializeProductRemoteDataSource();
            getIt.registerSingleton<ProductRemoteDataSource>(productRemoteDataSource);

            final searchRemoteDataSource = await _initializeSearchRemoteDataSource();
            getIt.registerSingleton<SearchRemoteDataSource>(searchRemoteDataSource);

            final categoryRemoteDataSource = await _initializeCategoryRemoteDataSource();
            getIt.registerSingleton<CategoryRemoteDataSource>(categoryRemoteDataSource);

            final profileRemoteDataSource = await _initializeProfileRemoteDataSource();
            getIt.registerSingleton<ProfileRemoteDataSource>(profileRemoteDataSource);

            final favoriteRemoteDataSource = await _initializeFavoriteRemoteDataSource();
            getIt.registerSingleton<FavoriteRemoteDataSource>(favoriteRemoteDataSource);

            final orderRemoteDataSource = await _initializeOrderRemoteDataSource();
            getIt.registerSingleton<OrderRemoteDataSource>(orderRemoteDataSource);

            //Repos
        getIt
            ..registerSingleton<AuthRepo>(AuthRepoImpl(
                localDataSource: getIt<AuthLocalDataSource>(),
                settingsLocalDataSource: getIt<SettingsLocalDataSource>(),
                services: getIt<Services>(),
                remoteDataSource: getIt<AuthRemoteDataSource>()))
            ..registerSingleton<FavoriteRepo>(FavoriteRepoImpl(
                services: getIt<Services>(),
                remoteDataSource: getIt<FavoriteRemoteDataSource>(),
                authLocalDataSource: getIt<AuthLocalDataSource>()))
            ..registerSingleton<ProductRepo>(ProductRepoImpl(
                remoteDataSource: getIt<ProductRemoteDataSource>(),
                localDataSource: getIt<ProductLocalDataSource>(),
                settingsLocalDataSource: getIt<SettingsLocalDataSource>(),
                services: getIt<Services>()))
            ..registerSingleton<SearchRepo>(SearchRepoImpl(
                remoteDataSource: getIt<SearchRemoteDataSource>(),
                localDataSource: getIt<SearchLocalDataSource>(),
                settingsLocalDataSource: getIt<SettingsLocalDataSource>(),
                services: getIt<Services>()))
            ..registerSingleton<CategoryRepo>(CategoryRepoImpl(
                categoryRemoteDataSource: getIt<CategoryRemoteDataSource>(),
                services: getIt<Services>(),))
            ..registerSingleton<CartRepo>(CartRepoImpl(
                remoteDataSource: getIt<ProductRemoteDataSource>(),
                localDataSource: getIt<CartLocalDataSource>(),
                settingsLocalDataSource: getIt<SettingsLocalDataSource>(),
                services: getIt<Services>()
            ))
            ..registerSingleton<ProfileRepo>(ProfileRepoImpl(
                remoteDataSource: getIt<ProfileRemoteDataSource>(),
                settingsLocalDataSource: getIt<SettingsLocalDataSource>(),
                services: getIt<Services>(),
                authLocalDataSource: getIt<AuthLocalDataSource>(),
            ))
            ..registerSingleton<OrderRepo>(OrderRepoImpl(
                remoteDataSource: getIt<OrderRemoteDataSource>(),
                services: getIt<Services>(),
                authLocalDataSource: getIt<AuthLocalDataSource>(),
            ) as OrderRepo)

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
            ..registerSingleton<GetUserTypeUsecase>(
                GetUserTypeUsecase(repo: getIt<AuthRepo>()))
            ..registerSingleton<LogoutUsecase>(
                LogoutUsecase(repo: getIt<AuthRepo>()))



            ..registerSingleton<GetImageByIdUsecase>(
                GetImageByIdUsecase(repo: getIt<ProductRepo>()))
            ..registerSingleton<GetProductByIdUsecase>(
                GetProductByIdUsecase(repo: getIt<ProductRepo>()))
            ..registerSingleton<DropAllProductsUsecase>(
                DropAllProductsUsecase(repo: getIt<ProductRepo>()))
            ..registerSingleton<GetProductsUsecase>(
                GetProductsUsecase(repo: getIt<ProductRepo>(),
                    dropAllProductsUsecase: getIt<DropAllProductsUsecase>(),
                    networkService: getIt<NetworkService>()))


            ..registerSingleton<AddToCartUsecase>(
                AddToCartUsecase(repo: getIt<CartRepo>()))
            ..registerSingleton<GetCartUsecase>(
                GetCartUsecase(repo: getIt<CartRepo>()))
            ..registerSingleton<RemoveFromCartUsecase>(
                RemoveFromCartUsecase(repo: getIt<CartRepo>()))
            ..registerSingleton<UpdateCartUsecase>(
                UpdateCartUsecase(repo: getIt<CartRepo>()))
            ..registerSingleton<ClearCartUsecase>(
                ClearCartUsecase(repo: getIt<CartRepo>()))


            ..registerSingleton<SearchUsecase>(
                SearchUsecase(repo: getIt<SearchRepo>()))
            ..registerSingleton<InsertRecentSearchUsecase>(
                InsertRecentSearchUsecase(repo: getIt<SearchRepo>()))
            ..registerSingleton<GetRecentSearchUsecase>(
                GetRecentSearchUsecase(repo: getIt<SearchRepo>()))
            ..registerSingleton<DeleteAllRecentSearchUsecase>(
                DeleteAllRecentSearchUsecase(repo: getIt<SearchRepo>()))
            ..registerSingleton<DeleteRecentSearchUsecase>(
                DeleteRecentSearchUsecase(repo: getIt<SearchRepo>()))


            ..registerSingleton<GetAllCategoriesUsecase>(
                GetAllCategoriesUsecase(repo: getIt<CategoryRepo>()))
            ..registerSingleton<GetCategoryProductsUsecase>(
                GetCategoryProductsUsecase(repo: getIt<CategoryRepo>()))
            ..registerSingleton<GetSubCategoriesUsecase>(
                GetSubCategoriesUsecase(repo: getIt<CategoryRepo>()))


            ..registerSingleton<ChangePasswordUsecase>(
                ChangePasswordUsecase(repo: getIt<ProfileRepo>()))
            ..registerSingleton<GetProfileUsecase>(
                GetProfileUsecase(repo: getIt<ProfileRepo>()))
            ..registerSingleton<UpdateProfileUsecase>(
                UpdateProfileUsecase(repo: getIt<ProfileRepo>()))
            ..registerSingleton<GetOrdersByStateUsecase>(
                GetOrdersByStateUsecase(repo: getIt<ProfileRepo>()))

            ..registerSingleton<GetUserFavoriteUsecase>(
                GetUserFavoriteUsecase(repo: getIt<FavoriteRepo>()))
            ..registerSingleton<AddToFavoriteUsecase>(
                AddToFavoriteUsecase(repo: getIt<FavoriteRepo>()))
            ..registerSingleton<RemoveFromFavoriteUsecase>(
                RemoveFromFavoriteUsecase(repo: getIt<FavoriteRepo>()))


            ..registerSingleton<MakeOrderUsecase>(
                MakeOrderUsecase(repo: getIt<OrderRepo>()))
            ..registerSingleton<MakeOrderItemsUsecase>(
                MakeOrderItemsUsecase(repo: getIt<OrderRepo>(),
                    clearCartUsecase: getIt<ClearCartUsecase>()));


    }

    static Future<AuthRemoteDataSource> _initializeAuthRemoteDataSource() async {
        return AuthRemoteDataSourceImpl(
            domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
            serviceEmail: (await getIt<SettingsLocalDataSource>().getServiceProviderEmail())!,
            servicePassword: (await getIt<SettingsLocalDataSource>().getServiceProviderPassword())!,
            client: getIt<Api>(),
        );
    }

    static Future<ProductRemoteDataSource> _initializeProductRemoteDataSource() async {
        return ProductRemoteDataSourceImpl(
            domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
            serviceEmail: (await getIt<SettingsLocalDataSource>().getServiceProviderEmail())!,
            servicePassword: (await getIt<SettingsLocalDataSource>().getServiceProviderPassword())!,
            client: getIt<Api>(),
            userId: (await getIt<SettingsLocalDataSource>().getServiceProviderUserId())!,
        );
    }

    static Future<SearchRemoteDataSource> _initializeSearchRemoteDataSource() async {
        return SearchRemoteDataSourceImpl(
            domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
            serviceEmail: (await getIt<SettingsLocalDataSource>().getServiceProviderEmail())!,
            servicePassword: (await getIt<SettingsLocalDataSource>().getServiceProviderPassword())!,
            client: getIt<Api>(),
            userId: (await getIt<SettingsLocalDataSource>().getServiceProviderUserId())!,
        );
    }

    static Future<CategoryRemoteDataSource> _initializeCategoryRemoteDataSource() async {
        return CategoryRemoteDataSourceImpl(
            domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
            serviceEmail: (await getIt<SettingsLocalDataSource>().getServiceProviderEmail())!,
            servicePassword: (await getIt<SettingsLocalDataSource>().getServiceProviderPassword())!,
            client: getIt<Api>(),
            userId: (await getIt<SettingsLocalDataSource>().getServiceProviderUserId())!,
        );
    }

    static Future<ProfileRemoteDataSource> _initializeProfileRemoteDataSource() async {
        return ProfileRemoteDataSourceImpl(
            domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
            serviceEmail: (await getIt<SettingsLocalDataSource>().getServiceProviderEmail())!,
            servicePassword: (await getIt<SettingsLocalDataSource>().getServiceProviderPassword())!,
            client: getIt<Api>(),
            userId: (await getIt<SettingsLocalDataSource>().getServiceProviderUserId())!,
        );
    }

    static Future<FavoriteRemoteDataSource> _initializeFavoriteRemoteDataSource() async {
        return FavoriteRemoteDataSourceImpl(
            domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
            client: getIt<Api>(),
            userID: (await getIt<SettingsLocalDataSource>().getServiceProviderUserId())!,
        );
    }

    static Future<OrderRemoteDataSource> _initializeOrderRemoteDataSource() async {
        return OrderRemoteDataSourceImpl(
            domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
            client: getIt<Api>(),
            serviceEmail: (await getIt<SettingsLocalDataSource>().getServiceProviderEmail())!,
            servicePassword: (await getIt<SettingsLocalDataSource>().getServiceProviderPassword())!,
            userId: (await getIt<SettingsLocalDataSource>().getServiceProviderUserId())!,
        );
    }


    static Future<AppDatabase> _initializeProductsDatabase() async {
        return await $FloorAppDatabase.databaseBuilder(AppConsts.mainDBName).build();

    }

    static Future<Box> _initializeHiveDatabase() async {
        await Hive.initFlutter();
        final appDocumentDirectory = await getApplicationDocumentsDirectory();
        Hive.init(appDocumentDirectory.path);
        return await Hive.openBox(AppConsts.prefDBName);

    }

    static Future<void> _seedingInitialValue() async {
        if(await getIt<SettingsLocalDataSource>().getServiceProviderDomain() == null){
            await getIt<SettingsLocalDataSource>().putServiceProviderDomain(AppConsts.domain);
        }

        if(await await getIt<SettingsLocalDataSource>().getServiceProviderEmail() == null){
            await getIt<SettingsLocalDataSource>().putServiceProviderEmail(AppConsts.serviceEmail);
        }

        if(await getIt<SettingsLocalDataSource>().getServiceProviderPassword() == null){
            await getIt<SettingsLocalDataSource>().putServiceProviderPassword(AppConsts.servicePassword);
        }

        if(await getIt<SettingsLocalDataSource>().getServiceProviderUserId() == null){
            await getIt<SettingsLocalDataSource>().putServiceProviderUserId(AppConsts.serviceUserId);
        }
    }


}

