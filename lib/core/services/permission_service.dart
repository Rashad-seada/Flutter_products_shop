import 'package:permission_handler/permission_handler.dart';

class PermissionService {

  late Permission permission;

  requestLocationPermission() async {
    if(await Permission.location.status.isDenied){
      return Permission.location.request();
    }
  }

  requestCameraPermission() async {
    if(await Permission.camera.status.isDenied){
      return Permission.camera.request();
    }
  }

  requestFilesPermission() async {
    if(await Permission.microphone.status.isDenied){
      return Permission.microphone.request();
    }
  }

}
