part of 'service_provider_cubit.dart';

abstract class ServiceProviderState extends Equatable {
  const ServiceProviderState();
}

class ServiceProviderInitial extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class ServiceProviderSavingConfig extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class ServiceProviderLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}
