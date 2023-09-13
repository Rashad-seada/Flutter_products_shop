part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderFailure extends OrderState {

  static Failure myError = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  OrderFailure(Failure error){
    myError = error;
  }

  @override
  List<Object> get props => [];
}

class OrderSuccess extends OrderState {

  static List<GetCountriesEntity> countries = [];

  static List<GetRegionsEntity> regions = [];

  static List<GetCitiesEntity> cities = [];


  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {
  @override
  List<Object> get props => [];
}
