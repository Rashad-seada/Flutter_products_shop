import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/exception.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/services/services.dart';
import 'package:eng_shop/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:eng_shop/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:eng_shop/features/auth/domain/entity/activate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/login_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/registration_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/reset_password_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/send_sms_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_code_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_email_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';
import 'package:eng_shop/features/main_feature/data/data_source/local_data_source/settings_local_data_source.dart';

class AuthRepoImpl implements AuthRepo {

  AuthRemoteDataSource remoteDataSource;
  AuthLocalDataSource localDataSource;
  SettingsLocalDataSource settingsLocalDataSource;
  Services services;

  AuthRepoImpl({required this.localDataSource,required this.settingsLocalDataSource,required this.services,required this.remoteDataSource});

  // initRemoteDataSource() async {
  //   try {
  //     remoteDataSource = AuthRemoteDataSourceImpl(
  //         domain: await mainLocalDataSource.getServiceProviderDomain(),
  //         serviceEmail: await mainLocalDataSource.getServiceProviderEmail(),
  //         servicePassword: await mainLocalDataSource.getServiceProviderPassword()
  //     );
  //   } catch (e) {
  //     throw LocalDataException();
  //   }
  //
  // }

  @override
  Future<Either<Failure, RegistrationEntity>> register(String userName, String email, String upass, String mobile,int screenCode) async {

    try {
      //await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
      }

      RegistrationEntity registrationEntity = await remoteDataSource.register(userName, userName, email, email, upass, mobile);

      if(registrationEntity.statusCode != 200) {
        return left(RemoteDataFailure("There is an error in the server please try again later", screenCode: screenCode, customCode: 00));
      }

      if(registrationEntity.res == null) {
        return left(RemoteDataFailure("The response returned with null", screenCode: screenCode, customCode: 01));
      }

      if (int.parse(registrationEntity.res!) < 0){
        return left(RemoteDataFailure(registrationEntity.msg ?? "There was unknown error in the server", screenCode: screenCode, customCode: 02));
      }

      localDataSource.putUserID(int.parse(registrationEntity.res!));

      return right(registrationEntity);

    } on RemoteDataException {
      return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));

    } on LocalDataException {
      return left(LocalDataFailure("There was a failure during the caching!", screenCode: screenCode, customCode: 00));

    } on ServiceException {
      return left(ServiceFailure("There was unknown error in network service provider", screenCode: screenCode, customCode: 00));

    }catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }


  }

  @override
  Future<Either<Failure, ValidateEmailEntity>> validateEmail(String email,int screenCode) async {

    try {
      //await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
      }

      ValidateEmailEntity validateEmailEntity = await remoteDataSource.validateEmail(email);

      if(validateEmailEntity.statusCode != 200) {
        return left(RemoteDataFailure("There is an error in the server please try again later", screenCode: screenCode, customCode: 00));
      }

      if(validateEmailEntity.res == null) {
        return left(RemoteDataFailure("The response returned with null", screenCode: screenCode, customCode: 01));
      }

      if (int.parse(validateEmailEntity.res!) != 0){
        return left(RemoteDataFailure(validateEmailEntity.msg ?? "There was unknown error in the server", screenCode: screenCode, customCode: 02));
      }

      return right(validateEmailEntity);

    } on RemoteDataException {
      return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));

    } on LocalDataException {
      return left(LocalDataFailure("There was a failure during the caching!", screenCode: screenCode, customCode: 00));

    } on ServiceException {
      return left(ServiceFailure("There was unknown error in network service provider", screenCode: screenCode, customCode: 00));

    }catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }

  }

  @override
  Future<Either<Failure, ValidatePhoneEntity>> validatePhone(String mobile,int screenCode) async {


    try {
      //await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
      }

      ValidatePhoneEntity validatePhoneEntity = await remoteDataSource.validatePhoneNumber(mobile);

      if(validatePhoneEntity.statusCode != 200) {
        return left(RemoteDataFailure("There is an error in the server please try again later", screenCode: screenCode, customCode: 00));
      }

      if(validatePhoneEntity.res == null) {
        return left(RemoteDataFailure("The response returned with null", screenCode: screenCode, customCode: 01));
      }

      if (int.parse(validatePhoneEntity.res!) != 0){
        return left(RemoteDataFailure(validatePhoneEntity.msg ?? "There was unknown error in the server", screenCode: screenCode, customCode: 02));
      }

      return right(validatePhoneEntity);

    } on RemoteDataException {
      return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));

    } on LocalDataException {
      return left(LocalDataFailure("There was a failure during the caching!", screenCode: screenCode, customCode: 00));

    } on ServiceException {
      return left(ServiceFailure("There was unknown error in network service provider", screenCode: screenCode, customCode: 00));

    }catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }
  }


  @override
  Future<Either<Failure, ActivatePhoneEntity>> activateAccountBySMS(String mobile, String pin, String expectedPin,int screenCode) async {

    try {
      //await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 00));
      }

      ActivatePhoneEntity activatePhoneEntity = await remoteDataSource.activateAccountSMS(mobile,pin,expectedPin);

      if(activatePhoneEntity.statusCode != 200) {
        return left(RemoteDataFailure("There is an error in the server please try again later", screenCode: screenCode, customCode: 00));
      }

      if(activatePhoneEntity.res == null) {
        return left(RemoteDataFailure("The response returned with null", screenCode: screenCode, customCode: 01));
      }

      if (int.parse(activatePhoneEntity.res!) == 0){
        return left(RemoteDataFailure(activatePhoneEntity.msg ?? "There was unknown error in the server", screenCode: screenCode, customCode: 02));
      }

      return right(activatePhoneEntity);

    } on RemoteDataException {
      return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));

    } on LocalDataException {
      return left(LocalDataFailure("There was a failure during the caching!", screenCode: screenCode, customCode: 00));

    } on ServiceException {
      return left(ServiceFailure("There was unknown error in network service provider", screenCode: screenCode, customCode: 00));

    }catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }

  }

  @override
  Future<Either<Failure, LoginEntity>> login(String email, String password,bool isMobile,int screenCode) async {


    try {
      //await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
      }

      LoginEntity loginEntity = await remoteDataSource.login(email, password,isMobile);

      if(loginEntity.statusCode != 200) {
        return left(RemoteDataFailure("There is an error in the server please try again later", screenCode: screenCode, customCode: 00));
      }

      if(loginEntity.res == null) {
        return left(RemoteDataFailure("The response returned with null", screenCode: screenCode, customCode: 01));
      }

      if (int.parse(loginEntity.res!) != 1){
        return left(RemoteDataFailure(loginEntity.msg ?? "There was unknown error in the server", screenCode: screenCode, customCode: 02));
      }

      localDataSource.putUserID(int.parse(loginEntity.id!));

      return right(loginEntity);

    } on RemoteDataException {
      return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));

    } on LocalDataException {
      return left(LocalDataFailure("There was a failure during the caching!", screenCode: screenCode, customCode: 00));

    } on ServiceException {
      return left(ServiceFailure("There was unknown error in network service provider", screenCode: screenCode, customCode: 00));

    }catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }

  }

  @override
  Future<Either<Failure, SendSmsEntity>> sendSms(String mobile,int screenCode) async {


    try {
      //await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
      }
      SendSmsEntity sendSmsEntity = await remoteDataSource.sendSms(mobile);

      if(sendSmsEntity.statusCode != 200) {
        return left(RemoteDataFailure("There is an error in the server please try again later", screenCode: screenCode, customCode: 00));
      }

      if(sendSmsEntity.res == null) {
        return left(RemoteDataFailure("The response returned with null", screenCode: screenCode, customCode: 01));
      }

      if (int.parse(sendSmsEntity.res!) != 1){
        return left(RemoteDataFailure(sendSmsEntity.msg ?? "There was unknown error in the server", screenCode: screenCode, customCode: 02));
      }

      return right(sendSmsEntity);

    } on RemoteDataException {
      return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));

    } on LocalDataException {
      return left(LocalDataFailure("There was a failure during the caching!", screenCode: screenCode, customCode: 00));

    } on ServiceException {
      return left(ServiceFailure("There was unknown error in network service provider", screenCode: screenCode, customCode: 00));

    }catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }

  }

  @override
  Future<Either<Failure, ValidateCodeEntity>> validateCode(String mobile,String smsCode,int screenCode) async {

    try {
      //await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
      }

      ValidateCodeEntity validateCodeEntity = await remoteDataSource.validateSmsCode(mobile,smsCode);

      if(validateCodeEntity.statusCode != 200) {
        return left(RemoteDataFailure("There is an error in the server please try again later", screenCode: screenCode, customCode: 00));
      }

      if(validateCodeEntity.res == null) {
        return left(RemoteDataFailure("The response returned with null", screenCode: screenCode, customCode: 01));
      }

      if (int.parse(validateCodeEntity.res!) != 1){
        return left(RemoteDataFailure(validateCodeEntity.msg ?? "There was unknown error in the server", screenCode: screenCode, customCode: 02));
      }

      return right(validateCodeEntity);

    } on RemoteDataException {
      return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));

    } on LocalDataException {
      return left(LocalDataFailure("There was a failure during the caching!", screenCode: screenCode, customCode: 00));

    } on ServiceException {
      return left(ServiceFailure("There was unknown error in network service provider", screenCode: screenCode, customCode: 00));

    }catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }

  }

  @override
  Future<Either<Failure, ResetPasswordEntity>> resetPassword(String mobile, String smsCode, String newPassword,int screenCode) async {

    try {
      //await initRemoteDataSource();

      if (await services.networkService.isConnected == false) {
        return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
      }

      ResetPasswordEntity resetPasswordEntity = await remoteDataSource.resetPassword(mobile,smsCode,newPassword);

      if(resetPasswordEntity.statusCode != 200) {
        return left(RemoteDataFailure("There is an error in the server please try again later", screenCode: screenCode, customCode: 00));
      }

      if(resetPasswordEntity.res == null) {
        return left(RemoteDataFailure("The response returned with null", screenCode: screenCode, customCode: 01));
      }

      if (int.parse(resetPasswordEntity.res!) != 1){
        return left(RemoteDataFailure(resetPasswordEntity.msg ?? "There was unknown error in the server", screenCode: screenCode, customCode: 02));
      }

      return right(resetPasswordEntity);

    } on RemoteDataException {
      return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));

    } on LocalDataException {
      return left(LocalDataFailure("There was a failure during the caching!", screenCode: screenCode, customCode: 00));

    } on ServiceException {
      return left(ServiceFailure("There was unknown error in network service provider", screenCode: screenCode, customCode: 00));

    }catch (e) {
      return left(InternalFailure(e.toString(), screenCode: screenCode, customCode: 00));
    }

  }


}