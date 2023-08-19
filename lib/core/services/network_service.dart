
import 'package:connectivity_plus/connectivity_plus.dart';

import '../error/exception.dart';

abstract class NetworkService {

  Future<bool> get isConnected;

}

class NetworkServiceImpl implements NetworkService {


  @override
  Future<bool> get isConnected async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      throw ServiceException();
    }
  }

}