import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';

import '../entities/change_password_entity.dart';
import '../entities/get_orders_entity.dart';
import '../entities/profile_entity.dart';
import '../entities/update_profile_entity.dart';

abstract class ProfileRepo {


  Future<Either<Failure,ProfileEntity>> getProfile({required int screenCode});

  Future<Either<Failure,UpdateProfileEntity>> updateProfile({String? name,String? email,String? mobile ,required int screenCode});

  Future<Either<Failure,ChangePasswordEntity>> changePassword({required String oldPassword,required String newPassword,required int screenCode});

  Future<Either<Failure,List<GetOrderItemsEntity>>> getOrderByState({required List<int> orderState,required int screenCode});

}