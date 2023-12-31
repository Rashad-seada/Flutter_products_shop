


import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/auth/domain/entity/activate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/login_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/registration_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/reset_password_by_email_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/send_sms_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_code_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_email_entity.dart';
import 'package:eng_shop/features/auth/domain/entity/validate_phone_entity.dart';
import 'package:eng_shop/features/auth/domain/util/user_type_enum.dart';

import '../entity/reset_password_by_sms_entity.dart';

abstract class AuthRepo {

 Future<Either<Failure,RegistrationEntity>> register(String userName,String email,String upass,String mobile,int screenCode);

 Future<Either<Failure,ValidateEmailEntity>> validateEmail(String email,int screenCode);

 Future<Either<Failure,ValidatePhoneEntity>> validatePhone(String mobile,int screenCode);

 Future<Either<Failure,ActivatePhoneEntity>> activateAccountBySMS(String mobile,String pin,String expectedPin,int screenCode);

 Future<Either<Failure,LoginEntity>> login(String email,String password,bool isMobile,int screenCode);

 Future<Either<Failure,void>> logout(int screenCode);


 Future<Either<Failure,SendSmsEntity>> sendSms(String mobile,int screenCode);

 Future<Either<Failure,ValidateCodeEntity>> validateCode(String mobile,String smsCode,int screenCode);

 Future<Either<Failure,ResetPasswordBySMSEntity>> resetPasswordBySMS(String mobile,String smsCode,String newPassword,int screenCode);

 Future<Either<Failure,ResetPasswordByEmailEntity>> resetPasswordByEmail(String email,int screenCode);

 Future<Either<Failure,UserType?>> getUserType(int screenCode);

}