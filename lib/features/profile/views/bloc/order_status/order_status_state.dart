part of 'order_status_cubit.dart';

abstract class OrderStatusState extends Equatable {
  const OrderStatusState();
}

class OrderStatusInitial extends OrderStatusState {
  @override
  List<Object> get props => [];
}

class OrderStatusLoading extends OrderStatusState {
  @override
  List<Object> get props => [];
}

class OrderStatusSuccess extends OrderStatusState {
  static List<GetOrderItemsEntity> orders = [];

  @override
  List<Object> get props => [];
}

class OrderStatusFailure extends OrderStatusState {
  static Failure myError = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  OrderStatusFailure(Failure error){
    myError = error;
  }

  @override
  List<Object> get props => [];
}
