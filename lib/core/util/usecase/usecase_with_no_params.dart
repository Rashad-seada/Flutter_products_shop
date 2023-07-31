import 'package:dartz/dartz.dart';

abstract class Usecase<T> {

  Future<Either<Failure,T>> call();

}