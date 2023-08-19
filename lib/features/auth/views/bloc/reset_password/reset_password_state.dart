part of 'reset_password_cubit.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();
}

class ResetPasswordInitial extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class ResetPasswordLoading extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class ResetPasswordSuccess extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class ResetPasswordFailure extends ResetPasswordState {

  static Failure myFailure = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  ResetPasswordFailure(Failure failure){
    myFailure = failure;
  }

  @override
  List<Object> get props => [];
}

class ResetPasswordResendSmsLoading extends ResetPasswordState {
  @override
  List<Object> get props => [];
}
