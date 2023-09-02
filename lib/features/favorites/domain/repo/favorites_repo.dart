import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/features/favorites/domain/entities/add_favorite_entity.dart';

import '../../../shop/domain/entity/product_entity.dart';

abstract class FavoriteRepo {

  Future<Either<Failure,AddFavoriteEntity>> addToFavorite({required int productId,required int screenCode});

  Future<Either<Failure,AddFavoriteEntity>> removeFromFavorite({required int productId,required int screenCode});

  Future<Either<Failure,List<ProductEntity>>> getUserFavorite({required int screenCode});

}