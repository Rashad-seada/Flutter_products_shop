import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/favorites/domain/repo/favorites_repo.dart';

import '../../../shop/domain/entity/product_entity.dart';


class GetUserFavoriteUsecase implements Usecase< List<ProductEntity>,GetUserFavoriteParams> {
  FavoriteRepo repo ;

  GetUserFavoriteUsecase({required this.repo});

  @override
  Future<Either<Failure,  List<ProductEntity>>> call(GetUserFavoriteParams params) async {
    return await repo.getUserFavorite(screenCode: params.screenCode);
  }
}

class GetUserFavoriteParams {
  int screenCode;

  GetUserFavoriteParams({required this.screenCode});
}