


import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/auth/domain/entity/registration_entity.dart';

abstract class AuthRepo {

 Future<Either<Failure,RegistrationEntity>> register(String userName,String email,String upass,String mobile,);

}