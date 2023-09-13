part of 'details_cubit.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();
}

class DetailsInitial extends DetailsState {
  @override
  List<Object> get props => [];
}


class DetailsLoading extends DetailsState {
  @override
  List<Object> get props => [];
}


class DetailsSuccess extends DetailsState {
  static ProductEntity productEntity = ProductEntity();

  @override
  List<Object> get props => [];
}


class DetailsFailure extends DetailsState {
  static Failure myError = Failure("", screenCode: 0, exceptionCode: 0, customCode: 0);

  DetailsFailure(Failure error){
    myError = error;
  }
  @override
  List<Object> get props => [];
}
