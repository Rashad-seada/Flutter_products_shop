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

class AuthRepoImpl implements AuthRepo {

  AuthRemoteDataSource remoteDataSource = AuthRemoteDataSourceImpl();
  AuthLocalDataSource localDataSource = AuthLocalDataSourceImpl();
  Services services = Services();


  @override
  Future<Either<Failure, RegistrationEntity>> register(String userName, String email, String upass, String mobile) async {
    if (await services.networkService.isConnected) {
      try {
        RegistrationEntity registrationEntity = await remoteDataSource.register(userName, userName, email, email, upass, mobile);


        if(registrationEntity.res != null) {
          if (int.parse(registrationEntity.res!) > 0){

            try{
              localDataSource.putUserID(int.parse(registrationEntity.res!));
            } on CacheException {
              return left(CacheFailure("There was a failure during the caching!"));
            }

          }else {
            return left(ServerFailure(registrationEntity.msg!));
          }
        }

        return right(registrationEntity);

      } on ServerException {
        return left(ServerFailure("The server is down, please try again later!"));
      }
    } else {
      return left(NetworkFailure("Please check your internet connection and try again!"));
    }


  }

  @override
  Future<Either<Failure, ValidateEmailEntity>> validateEmail(String email) async {
    if (await services.networkService.isConnected) {
      try {
        ValidateEmailEntity validateEmailEntity = await remoteDataSource.validateEmail(email);


        if(validateEmailEntity.res != null) {
          if (int.parse(validateEmailEntity.res!) != 0){
            return left(ServerFailure(validateEmailEntity.msg!));
          }
        }

        return right(validateEmailEntity);

      } on ServerException {
        return left(ServerFailure("The server is down, please try again later!"));
      }
    } else {
      return left(NetworkFailure("Please check your internet connection and try again!"));
    }
  }

  @override
  Future<Either<Failure, ValidatePhoneEntity>> validatePhone(String mobile) async {
    if (await services.networkService.isConnected) {
      try {
        ValidatePhoneEntity validatePhoneEntity = await remoteDataSource.validatePhoneNumber(mobile);


        if(validatePhoneEntity.res != null) {
          if (int.parse(validatePhoneEntity.res!) != 0){

            return left(ServerFailure(validatePhoneEntity.msg!));
          }
        }

        return right(validatePhoneEntity);

      } on ServerException {
        return left(ServerFailure("The server is down, please try again later!"));
      }
    } else {
      return left(NetworkFailure("Please check your internet connection and try again!"));
    }
  }

  @override
  Future<Either<Failure, ActivatePhoneEntity>> activateAccountBySMS(String mobile, String pin, String expectedPin) async {
    if (await services.networkService.isConnected) {
      try {
        ActivatePhoneEntity activatePhoneEntity = await remoteDataSource.activateAccountSMS(mobile,pin,expectedPin);

        print("${int.parse(activatePhoneEntity.res!)}");

        if(activatePhoneEntity.res != null) {
          if (int.parse(activatePhoneEntity.res!) == 0){
            return left(ServerFailure(activatePhoneEntity.msg!));
          }
        }

        return right(activatePhoneEntity);

      } on ServerException {
        return left(ServerFailure("The server is down, please try again later!"));
      }
    } else {
      return left(NetworkFailure("Please check your internet connection and try again!"));
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> login(String email, String password) async {

    if (await services.networkService.isConnected) {
      try {
        LoginEntity loginEntity = await remoteDataSource.login(email, password);

        print("${int.parse(loginEntity.res!)}");

        if(loginEntity.res != null) {
          if (int.parse(loginEntity.res!) != 1){
            return left(ServerFailure(loginEntity.msg!));
          }
        }

        return right(loginEntity);

      } on ServerException {
        return left(ServerFailure("The server is down, please try again later!"));
      }
    } else {
      return left(NetworkFailure("Please check your internet connection and try again!"));
    }
  }

  @override
  Future<Either<Failure, SendSmsEntity>> sendSms(String mobile) async {
    if (await services.networkService.isConnected) {
      try {
        SendSmsEntity sendSmsEntity = await remoteDataSource.sendSms(mobile);

        print("${int.parse(sendSmsEntity.res!)}");

        if(sendSmsEntity.res != null) {
          if (int.parse(sendSmsEntity.res!) != 1){
            return left(ServerFailure(sendSmsEntity.msg!));
          }
        }

        return right(sendSmsEntity);

      } on ServerException {
        return left(ServerFailure("The server is down, please try again later!"));
      }
    } else {
      return left(NetworkFailure("Please check your internet connection and try again!"));
    }
  }

  @override
  Future<Either<Failure, ValidateCodeEntity>> validateCode(String mobile,String smsCode) async {
    if (await services.networkService.isConnected) {
      try {
        ValidateCodeEntity validateCodeEntity = await remoteDataSource.validateSmsCode(mobile,smsCode);

        print("${int.parse(validateCodeEntity.res!)}");

        if(validateCodeEntity.res != null) {
          if (int.parse(validateCodeEntity.res!) != 1){
            return left(ServerFailure(validateCodeEntity.msg!));
          }
        }

        return right(validateCodeEntity);

      } on ServerException {
        return left(ServerFailure("The server is down, please try again later!"));
      }
    } else {
      return left(NetworkFailure("Please check your internet connection and try again!"));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordEntity>> resetPassword(String mobile, String smsCode, String newPassword) async {
    if (await services.networkService.isConnected) {
      try {
        ResetPasswordEntity resetPasswordEntity = await remoteDataSource.resetPassword(mobile,smsCode,newPassword);

        print("${int.parse(resetPasswordEntity.res!)}");

        if(resetPasswordEntity.res != null) {
          if (int.parse(resetPasswordEntity.res!) != 1){
            return left(ServerFailure(resetPasswordEntity.msg!));
          }
        }

        return right(resetPasswordEntity);

      } on ServerException {
        return left(ServerFailure("The server is down, please try again later!"));
      }
    } else {
      return left(NetworkFailure("Please check your internet connection and try again!"));
    }
  }


}