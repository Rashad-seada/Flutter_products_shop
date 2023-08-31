part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSuccess extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileFailure extends ProfileState {

  static Failure myFailure = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  ProfileFailure(Failure failure){
    myFailure = failure;
  }

  @override
  List<Object> get props => [];
}
