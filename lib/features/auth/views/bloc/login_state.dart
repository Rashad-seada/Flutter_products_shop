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
  @override
  List<Object> get props => [];
}

Flushbar(
backgroundColor: AppTheme.primary500,
title: 'Welcome',
message:
'you just logged in to your account, have fun!',
duration: Duration(seconds: 3),
).show(context);
