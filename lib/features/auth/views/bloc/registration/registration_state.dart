part of 'registration_cubit.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationLoading extends RegistrationState {
  @override
  List<Object> get props => [];
}


class RegistrationSuccess extends RegistrationState {
  @override
  List<Object> get props => [];
}


class RegistrationFailure extends RegistrationState {

  static Failure myFailure = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  RegistrationFailure(Failure failure){
    myFailure = failure;
  }

  @override
  List<Object> get props => [];
}

class RegistrationValidatingEmail extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationValidatingPhone extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationActivatingAccountBySms extends RegistrationState {
  @override
  List<Object> get props => [];
}