import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  String message;
  List<dynamic> properties;

  Failure(this.message,{this.properties = const <dynamic>[]});

  @override
  List<Object?> get props => properties;
}


class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}