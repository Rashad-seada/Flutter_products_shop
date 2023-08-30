import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:eng_shop/features/profile/data/repo/profile_repo.dart';
import 'package:eng_shop/features/profile/domain/entities/change_password_entity.dart';
import 'package:eng_shop/features/profile/domain/entities/profile_entity.dart';
import 'package:eng_shop/features/profile/domain/entities/update_profile_entity.dart';

import '../../../../core/di/app_module.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/infrastructure/api/api.dart';
import '../../../../core/infrastructure/services/services.dart';
import '../../../auth/data/data_source/local_data_source/auth_local_data_source.dart';
import '../../../settings/data/data_source/local/settings_local_data_source.dart';

class ProfileRepoImpl implements ProfileRepo {



  ProfileRemoteDataSource remoteDataSource;
  AuthLocalDataSource authLocalDataSource;
  SettingsLocalDataSource settingsLocalDataSource;
  Services services;


  ProfileRepoImpl(
      {required this.remoteDataSource,
        required this.authLocalDataSource,
        required this.settingsLocalDataSource,
        required this.services});

  initRemoteDataSource() async {
    try {
      remoteDataSource = ProfileRemoteDataSourceImpl(
          domain: (await getIt<SettingsLocalDataSource>().getServiceProviderDomain())!,
          serviceEmail: (await getIt<SettingsLocalDataSource>().getServiceProviderEmail())!,
          servicePassword: (await getIt<SettingsLocalDataSource>().getServiceProviderPassword())!,
          client: getIt<Api>()
      );
    } catch (e) {
      throw LocalDataException();
    }
  }


  @override
  Future<Either<Failure, ProfileEntity>> getProfile({required int screenCode}) async {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      ProfileEntity profileEntity = await remoteDataSource.getProfile(
          id: (await authLocalDataSource.getUserID())! ,
          email:  (await authLocalDataSource.getEmail())!,
          password:  (await authLocalDataSource.getPassword())!
      );

      if(profileEntity.id == null) {
        return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 02));
      }

      if(profileEntity.statusCode != 200) {
        return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
      }

      return right(profileEntity);


    } on RemoteDataException {
      return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on ServiceException {
      return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }



  @override
  Future<Either<Failure, ChangePasswordEntity>> changePassword({required String oldPassword, required String newPassword,required int screenCode}) async {

    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      ChangePasswordEntity changePasswordEntity = await remoteDataSource.changePassword(
          id: (await authLocalDataSource.getUserID())! ,
          email:  (await authLocalDataSource.getEmail())!,
          oldPassword: oldPassword,
          newPassword: newPassword,
    );

    if(changePasswordEntity.res == "1") {
      return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 02));
    }

    if(changePasswordEntity.statusCode != 200) {
      return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
    }

      return right(changePasswordEntity);


    } on RemoteDataException {
      return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on ServiceException {
      return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }


  @override
  Future<Either<Failure, UpdateProfileEntity>> updateProfile({String? name, String? email, String? mobile,required int screenCode}) async  {
    try {
      await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure(ErrorMessages.network, screenCode: screenCode, customCode: 01));
      }

      UpdateProfileEntity updateProfileEntity = await remoteDataSource.updateProfile(
          id: (await authLocalDataSource.getUserID())! ,
          email:  email,
          name: name,
          mobile: mobile
    );

    if(updateProfileEntity.res == "1") {
    return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 02));
    }

    if(updateProfileEntity.statusCode != 200) {
    return left(RemoteDataFailure(ErrorMessages.server, screenCode: screenCode, customCode: 00));
    }

    return right(updateProfileEntity);


    } on RemoteDataException {
    return left(RemoteDataFailure(ErrorMessages.serverDown, screenCode: screenCode, customCode: 00));
    } on ServiceException {
    return left(ServiceFailure(ErrorMessages.serviceProvider, screenCode: screenCode, customCode: 00));
    } catch (e) {
    return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }



}