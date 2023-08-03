import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/exception.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/services/services.dart';
import 'package:eng_shop/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:eng_shop/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:eng_shop/features/auth/domain/entity/activate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/registration_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_email_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/repo/auth_repo.dart';
import 'package:flutter/foundation.dart';

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
  Future<Either<Failure, ValidateMobileEntity>> validateEmail(String email) async {
    if (await services.networkService.isConnected) {
      try {
        ValidateMobileEntity validateEmailEntity = await remoteDataSource.validateEmail(email);


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


}