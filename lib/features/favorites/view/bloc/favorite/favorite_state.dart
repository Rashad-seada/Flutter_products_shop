part of 'favorite_cubit.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoriteInitial extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteFailure extends FavoriteState {

  static Failure myError = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  FavoriteFailure(Failure error){
    myError = error;
  }

  @override
  List<Object> get props => [];
}

class FavoriteSuccess extends FavoriteState {

  static List<ProductEntity> products = [];

  static List<int> favoriteIds = [];


  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteItemLoading extends FavoriteState {
  @override
  List<Object> get props => [];
}
