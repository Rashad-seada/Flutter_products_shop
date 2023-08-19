part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailure extends LoginState {

  static Failure myFailure = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  LoginFailure(Failure failure){
    myFailure = failure;
  }

  @override
  List<Object> get props => [];
}


