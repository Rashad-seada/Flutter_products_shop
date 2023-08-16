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
  @override
  List<Object> get props => [];
}
