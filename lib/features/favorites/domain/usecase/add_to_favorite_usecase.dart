import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/favorites/domain/repo/favorites_repo.dart';

import '../entities/add_favorite_entity.dart';


class AddToFavoriteUsecase implements Usecase<AddFavoriteEntity,AddToFavoriteParams> {
  FavoriteRepo repo ;

  AddToFavoriteUsecase({required this.repo});

  @override
  Future<Either<Failure, AddFavoriteEntity>> call(AddToFavoriteParams params) async {
    return await repo.addToFavorite(productId: params.productId, screenCode: params.screenCode);
  }
}

class AddToFavoriteParams {
  int screenCode;
  int productId;

  AddToFavoriteParams({required this.productId,required this.screenCode});
}