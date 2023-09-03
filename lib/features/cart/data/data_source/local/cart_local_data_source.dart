import '../../../../../core/error/exception.dart';
import '../../../../../core/infrastructure/database/database.dart';
import '../../../domain/entity/cart_entity.dart';
import '../../../../shop/domain/entity/product_entity.dart';

abstract class CartLocalDataSource {

  //cart products
  Future<List<CartEntity>> getCartProducts();
  Future<List<int>> getCartProductsId();
  Future<void> insertAllCartProduct(List<ProductEntity> productEntity);
  Future<void> insertCartProduct(ProductEntity productEntity);
  Future<void> deleteCartProduct(ProductEntity productEntity);
  Future<void> updateCartProduct(CartEntity cartEntity);
  Future<void> dropAllCartProducts();

}

class CartLocalDataSourceImpl implements CartLocalDataSource {

  AppDatabase database;
  CartLocalDataSourceImpl(this.database);


  @override
  Future<List<CartEntity>> getCartProducts() async {
    try{
      return await database.productCartDao.getProducts();

    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<List<int>> getCartProductsId() async {
    try{
      return await database.productCartDao.getProductsIds();

    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> insertAllCartProduct(List<ProductEntity> productEntity) async {
    try{
      await database.productCartDao.insertAllProducts(productEntity.map((e) => CartEntity.fromProduct(e)).toList());

    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> insertCartProduct(ProductEntity productEntity) async {
    try{
      await database.productCartDao.insertProduct(CartEntity.fromProduct(productEntity));

    } catch (e) {
      print(e);

      throw LocalDataException();
    }
  }

  @override
  Future<void> deleteCartProduct(ProductEntity productEntity) async {
    try{
      return await database.productCartDao.deleteProduct(CartEntity.fromProduct(productEntity));

    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> updateCartProduct(CartEntity cartEntity) async {
    try{
      return await database.productCartDao.updateProduct(cartEntity);

    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> dropAllCartProducts() async {
    try{
      await database.productCartDao.dropAllCart();
    } catch (e) {
      throw LocalDataException();
    }
  }

}