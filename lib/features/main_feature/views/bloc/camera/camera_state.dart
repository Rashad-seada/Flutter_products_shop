part of 'camera_cubit.dart';

abstract class CameraState extends Equatable {
  const CameraState();
}

class CameraInitial extends CameraState {
  @override
  List<Object> get props => [];
}

class CameraSelectingImage extends CameraState {
  @override
  List<Object> get props => [];
}
