import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/favorites/domain/repo/favorites_repo.dart';

import '../entities/add_favorite_entity.dart';


class RemoveFromFavoriteUsecase implements Usecase<AddFavoriteEntity,RemoveFromFavoriteParams> {
  FavoriteRepo repo ;

  RemoveFromFavoriteUsecase({required this.repo});

  @override
  Future<Either<Failure, AddFavoriteEntity>> call(RemoveFromFavoriteParams params) async {
    return await repo.removeFromFavorite(productId: params.productId, screenCode: params.screenCode);
  }
}

class RemoveFromFavoriteParams {
  int screenCode;
  int productId;

  RemoveFromFavoriteParams({required this.productId,required this.screenCode});
}