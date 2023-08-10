


import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/auth/domain/entity/activate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/login_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/registration_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/send_sms_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_code_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_email_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_phone_entity.dart';

import '../entity/reset_password_entity.dart';

abstract class AuthRepo {

 Future<Either<Failure,RegistrationEntity>> register(String userName,String email,String upass,String mobile,);

 Future<Either<Failure,ValidateEmailEntity>> validateEmail(String email,);

 Future<Either<Failure,ValidatePhoneEntity>> validatePhone(String mobile,);

 Future<Either<Failure,ActivatePhoneEntity>> activateAccountBySMS(String mobile,String pin,String expectedPin);

 Future<Either<Failure,LoginEntity>> login(String email,String password,bool isMobile);

 Future<Either<Failure,SendSmsEntity>> sendSms(String mobile);

 Future<Either<Failure,ValidateCodeEntity>> validateCode(String mobile,String smsCode);

 Future<Either<Failure,ResetPasswordEntity>> resetPassword(String mobile,String smsCode,String newPassword);

}