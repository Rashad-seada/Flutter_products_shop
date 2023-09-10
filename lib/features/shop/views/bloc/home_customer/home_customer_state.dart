part of 'home_customer_cubit.dart';

abstract class HomeCustomerState extends Equatable {
  const HomeCustomerState();
}

class HomeCustomerInitial extends HomeCustomerState {
  @override
  List<Object> get props => [];
}

class HomeCustomerIsLoading extends HomeCustomerState {
  @override
  List<Object> get props => [];
}

class HomeCustomerSuccess extends HomeCustomerState {

  static List<ProductEntity> products = [];

  static ProductEntity productEntity = ProductEntity();

  static List<CategoryEntity> categories = [];

  @override
  List<Object> get props => [];
}

class HomeCustomerFailure extends HomeCustomerState {

  static Failure myError = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  HomeCustomerFailure(Failure error){
    myError = error;
  }

  @override
  List<Object> get props => [];
}


