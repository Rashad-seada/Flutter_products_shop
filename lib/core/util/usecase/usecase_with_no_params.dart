import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class Usecase<T> {

  Future<Either<Failure,T>> call();

}