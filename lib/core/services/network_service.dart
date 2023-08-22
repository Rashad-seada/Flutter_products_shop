
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../error/exception.dart';

abstract class NetworkService {

  Future<bool> get isConnected;

}

class NetworkServiceImpl implements NetworkService {

  InternetConnection internetConnection = InternetConnection();


  @override
  Future<bool> get isConnected async {
    try {
      return await InternetConnection().hasInternetAccess;
    } catch (e) {
      throw ServiceException();
    }
  }

}