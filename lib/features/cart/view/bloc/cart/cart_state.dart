part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartSuccess extends CartState {
  static List<CartResponse> cart = [];
  @override
  List<Object> get props => [];
}

class CartFailure extends CartState {
  static Failure myError = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);
  CartFailure(Failure error){
    myError = error;
  }
  @override
  List<Object> get props => [];
}

class CartAddingToCart extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}


