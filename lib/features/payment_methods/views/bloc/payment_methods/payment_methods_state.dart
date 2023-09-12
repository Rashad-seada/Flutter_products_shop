part of 'payment_methods_cubit.dart';

abstract class PaymentMethodsState extends Equatable {
  const PaymentMethodsState();
}

class PaymentMethodsInitial extends PaymentMethodsState {
  @override
  List<Object> get props => [];
}
