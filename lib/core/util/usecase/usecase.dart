import 'package:dartz/dartz.dart';

import 'package:eng_shop/core/error/failure.dart';

abstract class Usecase<T,Params> {

  Future<Either<Failure,T>> call(Params params);

}