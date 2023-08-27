
import 'package:eng_shop/core/infrastructure/services/permission_service.dart';

import 'camera_service.dart';
import 'google_service.dart';
import 'locale_service.dart';
import 'location_service.dart';
import 'network_service.dart';

class Services {

  final NetworkService networkService = NetworkServiceImpl();

  final GoogleService googleService = GoogleService();

  final CameraService cameraService = CameraService();

  final LocationService locationService = LocationService();

  final PermissionService permissionService = PermissionService();

  final LocaleService localeService = LocaleService();

}