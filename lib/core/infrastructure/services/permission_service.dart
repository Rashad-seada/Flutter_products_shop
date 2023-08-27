import 'package:permission_handler/permission_handler.dart';

import '../../error/exception.dart';

class PermissionService {

  late Permission permission;

  requestLocationPermission() async {
    try {
      if(await Permission.location.status.isDenied){
        return Permission.location.request();
      }
    } catch (e) {
      throw ServiceException();
    }

  }

  requestCameraPermission() async {
    try {
      if(await Permission.camera.status.isDenied){
        return Permission.camera.request();
      }
    } catch (e) {
      throw ServiceException();
    }

  }

  requestFilesPermission() async {
    try {
      if(await Permission.microphone.status.isDenied){
        return Permission.microphone.request();
      }
    } catch (e) {
      throw ServiceException();
    }

  }

}
