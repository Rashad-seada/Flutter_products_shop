part of 'category_product_cubit.dart';

abstract class CategoryProductState extends Equatable {
  const CategoryProductState();
}

class CategoryProductInitial extends CategoryProductState {
  @override
  List<Object> get props => [];
}

class CategoryProductSuccess extends CategoryProductState {

  static List<ProductEntity> products = [];

  @override
  List<Object> get props => [];
}


class CategoryProductFailure extends CategoryProductState {

  static Failure myError = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);
  CategoryProductFailure(Failure error){
    myError = error;
  }

  @override
  List<Object> get props => [];
}

class CategoryProductLoading extends CategoryProductState {
  @override
  List<Object> get props => [];
}

