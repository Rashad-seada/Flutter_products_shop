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

  late AuthRemoteDataSource remoteDataSource ;
  AuthLocalDataSource localDataSource = AuthLocalDataSourceImpl();
  SettingsLocalDataSource mainLocalDataSource = SettingsLocalDataSourceImpl();
  Services services = Services();

  initRemoteDataSource()async {
    remoteDataSource = AuthRemoteDataSourceImpl(
          domain: await mainLocalDataSource.getServiceProviderDomain(),
          serviceEmail: await mainLocalDataSource.getServiceProviderEmail(),
          servicePassword: await mainLocalDataSource.getServiceProviderPassword()
      );
  }

  @override
  Future<Either<Failure, RegistrationEntity>> register(String userName, String email, String upass, String mobile,int screenCode) async {
    await initRemoteDataSource();

    if (await services.networkService.isConnected) {
      try {
        RegistrationEntity registrationEntity = await remoteDataSource.register(userName, userName, email, email, upass, mobile);


        if(registrationEntity.res != null) {
          if (int.parse(registrationEntity.res!) > 0){

            try{
              localDataSource.putUserID(int.parse(registrationEntity.res!));
            } on LocalDataException {
              return left(LocalDataFailure("There was a failure during the caching!", screenCode: screenCode, customCode: 00));
            }

          }else {
            return left(RemoteDataFailure(registrationEntity.msg!, screenCode: screenCode, customCode: 00));
          }
        }

        return right(registrationEntity);

      } on RemoteDataException {
        return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));
      }
    } else {
      return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 00));
    }


  }

  @override
  Future<Either<Failure, ValidateEmailEntity>> validateEmail(String email,int screenCode) async {
    await initRemoteDataSource();

    if (await services.networkService.isConnected) {
      try {
        ValidateEmailEntity validateEmailEntity = await remoteDataSource!.validateEmail(email);


        if(validateEmailEntity.res != null) {
          if (int.parse(validateEmailEntity.res!) != 0){
            return left(RemoteDataFailure(validateEmailEntity.msg!, screenCode: screenCode, customCode: 01));
          }
        }

        return right(validateEmailEntity);

      } on RemoteDataException {
        return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));
      }
    } else {
      return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
    }
  }

  @override
  Future<Either<Failure, ValidatePhoneEntity>> validatePhone(String mobile,int screenCode) async {
    await initRemoteDataSource();

    if (await services.networkService.isConnected) {
      try {
        ValidatePhoneEntity validatePhoneEntity = await remoteDataSource!.validatePhoneNumber(mobile);


        if(validatePhoneEntity.res != null) {
          if (int.parse(validatePhoneEntity.res!) != 0){

            return left(RemoteDataFailure(validatePhoneEntity.msg!, screenCode: screenCode, customCode: 1));
          }
        }

        return right(validatePhoneEntity);

      } on RemoteDataException {
        return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));
      }
    } else {
      return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
    }
  }

  @override
  Future<Either<Failure, ActivatePhoneEntity>> activateAccountBySMS(String mobile, String pin, String expectedPin,int screenCode) async {
    await initRemoteDataSource();

    if (await services.networkService.isConnected) {
      try {
        ActivatePhoneEntity activatePhoneEntity = await remoteDataSource.activateAccountSMS(mobile,pin,expectedPin);

        print("${int.parse(activatePhoneEntity.res!)}");

        if(activatePhoneEntity.res != null) {
          if (int.parse(activatePhoneEntity.res!) == 0){
            return left(RemoteDataFailure(activatePhoneEntity.msg!, screenCode: screenCode, customCode: 01));
          }
        }

        return right(activatePhoneEntity);

      } on RemoteDataException {
        return left(RemoteDataFailure( "200 The server is down, please try again later!", screenCode: screenCode, customCode: 00));
      }
    } else {
      return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 00));
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> login(String email, String password,bool isMobile,int screenCode) async {
    await initRemoteDataSource();

    if (await services.networkService.isConnected) {
      try {
        LoginEntity loginEntity = await remoteDataSource.login(email, password,isMobile);

        if(loginEntity.res != null) {
          if (int.parse(loginEntity.res!) != 1){
            return left(RemoteDataFailure(loginEntity.msg!, screenCode: screenCode, customCode: 01));
          }else {
            localDataSource.putUserID(int.parse(loginEntity.id!));
          }
        }

        return right(loginEntity);

      } on RemoteDataException{
        return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));
      }
    } else {
      return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
    }
  }

  @override
  Future<Either<Failure, SendSmsEntity>> sendSms(String mobile,int screenCode) async {
    await initRemoteDataSource();

    if (await services.networkService.isConnected) {
      try {
        SendSmsEntity sendSmsEntity = await remoteDataSource.sendSms(mobile);

        print("${int.parse(sendSmsEntity.res!)}");

        if(sendSmsEntity.res != null) {
          if (int.parse(sendSmsEntity.res!) != 1){
            return left(RemoteDataFailure(sendSmsEntity.msg!, screenCode: screenCode, customCode: 01));
          }
        }

        return right(sendSmsEntity);

      } on RemoteDataException {
        return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));
      }
    } else {
      return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
    }
  }

  @override
  Future<Either<Failure, ValidateCodeEntity>> validateCode(String mobile,String smsCode,int screenCode) async {
    await initRemoteDataSource();

    if (await services.networkService.isConnected) {
      try {
        ValidateCodeEntity validateCodeEntity = await remoteDataSource.validateSmsCode(mobile,smsCode);

        print("${int.parse(validateCodeEntity.res!)}");

        if(validateCodeEntity.res != null) {
          if (int.parse(validateCodeEntity.res!) != 1){
            return left(RemoteDataFailure(validateCodeEntity.msg!, screenCode: screenCode, customCode: 01));
          }
        }

        return right(validateCodeEntity);

      } on RemoteDataException {
        return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));
      }
    } else {
      return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordEntity>> resetPassword(String mobile, String smsCode, String newPassword,int screenCode) async {
    await initRemoteDataSource();

    if (await services.networkService.isConnected) {
      try {
        ResetPasswordEntity resetPasswordEntity = await remoteDataSource!.resetPassword(mobile,smsCode,newPassword);

        print("${int.parse(resetPasswordEntity.res!)}");

        if(resetPasswordEntity.res != null) {
          if (int.parse(resetPasswordEntity.res!) != 1){
            return left(RemoteDataFailure(resetPasswordEntity.msg!, screenCode: screenCode, customCode: 01));
          }
        }

        return right(resetPasswordEntity);

      } on RemoteDataException {
        return left(RemoteDataFailure("The server is down, please try again later!", screenCode: screenCode, customCode: 00));
      }
    } else {
      return left(ServiceFailure("Please check your internet connection and try again!", screenCode: screenCode, customCode: 01));
    }
  }


}