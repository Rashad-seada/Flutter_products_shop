part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomePageChanged extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeIsLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSuccess extends HomeState {

  static List<ProductEntity> products = [];

  @override
  List<Object> get props => [];
}

class HomeFailure extends HomeState {

  static Failure myError = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  HomeFailure(Failure error){
    myError = error;
  }

  @override
  List<Object> get props => [];
}
