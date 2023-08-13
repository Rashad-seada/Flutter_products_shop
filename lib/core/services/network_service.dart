import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

import '../error/exception.dart';

abstract class NetworkService {

  Future<bool> get isConnected;

}

class NetworkServiceImpl implements NetworkService {

  final DataConnectionChecker connectionChecker = DataConnectionChecker();

  @override
  Future<bool> get isConnected {
    try {
      return connectionChecker.hasConnection;
    } catch (e) {
      throw ServiceException();
    }
  }

}