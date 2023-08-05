part of 'auth_methods_cubit.dart';

abstract class AuthMethodsState extends Equatable {
  const AuthMethodsState();
}

class AuthMethodsInitial extends AuthMethodsState {
  @override
  List<Object> get props => [];
}

class AuthMethodsGoogleLoading extends AuthMethodsState {
  @override
  List<Object> get props => [];
}

class AuthMethodsFacebookLoading extends AuthMethodsState {
  @override
  List<Object> get props => [];
}

