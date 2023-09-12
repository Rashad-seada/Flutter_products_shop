import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/categories/domain/entities/category_entity.dart';
import 'package:eng_shop/features/categories/domain/repo/category_repo.dart';

import '../../../../core/infrastructure/services/network_service.dart';


class GetAllCategoriesUsecase implements Usecase<List<CategoryEntity>,GetAllCategoriesParams> {
  CategoryRepo repo ;
  NetworkService networkService;

  GetAllCategoriesUsecase({required this.repo,required this.networkService});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(GetAllCategoriesParams params) async {

    if(await networkService.isConnected == false){
      return call(params);
    }else{
      return await repo.getAllCategories(params.screenCode);

    }
  }
}

class GetAllCategoriesParams {
  int screenCode;

  GetAllCategoriesParams(this.screenCode);
}