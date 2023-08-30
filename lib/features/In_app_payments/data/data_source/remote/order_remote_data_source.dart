abstract class OrderRemoteDataSource {

  Future<> getMyOrder();

  Future<> getMyOrderItems();

  Future<> makeOrder();

  Future<> makeOrderItems();

  Future<> makeOrderItem();

}


class OrderRemoteDataSourceImpl implements  OrderRemoteDataSource {

}