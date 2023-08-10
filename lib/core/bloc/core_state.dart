part of 'core_cubit.dart';

abstract class CoreState extends Equatable {
  const CoreState();
}

class CoreInitial extends CoreState {
  @override
  List<Object> get props => [];
}

class CoreLoading extends CoreState {
  @override
  List<Object> get props => [];
}
