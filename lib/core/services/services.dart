
import 'package:eng_shop/core/services/google_service.dart';
import 'package:eng_shop/core/services/location_service.dart';
import 'package:eng_shop/core/services/network_service.dart';
import 'package:eng_shop/core/services/permission_service.dart';

import 'camera_service.dart';

class Services {

  final NetworkService networkService = NetworkServiceImpl();

  final GoogleService googleService = GoogleService();

  final CameraService cameraService = CameraService();

  final LocationService locationService = LocationService();

  final PermissionService permissionService = PermissionService();

}