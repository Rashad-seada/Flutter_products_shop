part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesSuccess extends CategoriesState {
  static List<CategoryEntity> categories = [];

  static Map<int,List<CategoryEntity>> subCategories = {};


  @override
  List<Object> get props => [];
}


class CategoriesFailure extends CategoriesState {
  static Failure myError = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  CategoriesFailure(Failure error){
    myError = error;
  }
  @override
  List<Object> get props => [];
}


class CategoriesLoading extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesSubLoading extends CategoriesState {
  @override
  List<Object> get props => [];
}


class CategoriesNetworkError extends CategoriesState {
  @override
  List<Object> get props => [];
}

