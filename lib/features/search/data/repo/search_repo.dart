import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../shop/domain/entity/product_entity.dart';

abstract class SearchRepo {

  //search
  Future<Either<Failure, List<ProductEntity>>> searchProduct(String searchTerm,int screenCode);

}