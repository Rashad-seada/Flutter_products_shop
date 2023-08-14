import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/di/app_module.dart';
import 'package:eng_shop/core/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());

  List<XFile> photos = [

  ];

  onCameraTap() {
    getIt<Services>().cameraService.takeImage().then(
      (value) {
        if(value != null){
          photos.add(value);
          emit(CameraSelectingImage());
          emit(CameraInitial());
        }
      }
    );
  }




}
