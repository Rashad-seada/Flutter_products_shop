part of 'payment_methods_cubit.dart';

abstract class PaymentMethodsState extends Equatable {
  const PaymentMethodsState();
}

class PaymentMethodsInitial extends PaymentMethodsState {
  @override
  List<Object> get props => [];
}

class PaymentMethodsLoading extends PaymentMethodsState {
  @override
  List<Object> get props => [];
}

class PaymentMethodsSuccess extends PaymentMethodsState {
  @override
  List<Object> get props => [];
}

class PaymentMethodsFailure extends PaymentMethodsState {
  @override
  List<Object> get props => [];
}

class PaymentMethodsSelect extends PaymentMethodsState {
  @override
  List<Object> get props => [];
}
