import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  String message;
  int screenCode;
  int exceptionCode;
  int customCode;

  String toString(){
    return "$screenCode$exceptionCode$customCode";
  }

  int code(){
    return int.parse("$screenCode$exceptionCode$customCode");
  }

  List<dynamic> properties;

  Failure(this.message,
      {this.properties = const <dynamic>[],
      required this.screenCode,
      required this.exceptionCode,
      required this.customCode});

  @override
  List<Object?> get props => properties;
}

class InternalFailure extends Failure {
  InternalFailure(String message,
      {required int screenCode, required int customCode})
      : super(message,
      exceptionCode: 1, screenCode: screenCode, customCode: customCode);
}

class RemoteDataFailure extends Failure {
  RemoteDataFailure(String message,
      {required int screenCode, required int customCode})
      : super(message,
            exceptionCode: 2, screenCode: screenCode, customCode: customCode);
}

class LocalDataFailure extends Failure {
  LocalDataFailure(String message,
      {required int screenCode, required int customCode})
      : super(message,
      exceptionCode: 3, screenCode: screenCode, customCode: customCode);
}

class ServiceFailure extends Failure {
  ServiceFailure(String message,
      {required int screenCode, required int customCode})
      : super(message,
      exceptionCode: 4, screenCode: screenCode, customCode: customCode);
}




