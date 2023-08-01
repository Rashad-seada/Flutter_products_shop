import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/exception.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/services/services.dart';
import 'package:eng_shop/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:eng_shop/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:eng_shop/features/auth/domain/entity/registration_entity.dart';
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
          try{
            localDataSource.putUserID(int.parse(registrationEntity.res!));
          } on CacheException {
            return left(CacheFailure("There was a failure during the caching!"));
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


}