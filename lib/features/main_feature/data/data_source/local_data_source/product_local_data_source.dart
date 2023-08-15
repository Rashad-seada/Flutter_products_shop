import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';

import 'database/database.dart';

abstract class ProductLocalDataSource {

  //favorite products
  Future<List<ProductEntity>> getCartProducts();
  Future<List<int>> getCartProductsId();
  Future<void> insertAllCartProduct(List<ProductEntity> productEntity);
  Future<void> insertCartProduct(ProductEntity productEntity);
  Future<void> deleteCartProduct(ProductEntity productEntity);

  //products
  Future<List<ProductEntity>> getProducts();
  Future<List<int>> getProductsId();
  Future<void> insertAllProduct(List<ProductEntity> productEntity);
  Future<void> insertProduct(ProductEntity productEntity);
  Future<void> deleteProduct(ProductEntity productEntity);

  //favorite products
  Future<List<ProductEntity>> getFavoriteProducts();
  Future<List<int>> getFavoriteProductsId();
  Future<void> insertAllFavoriteProduct(List<ProductEntity> productEntity);
  Future<void> insertFavoriteProduct(ProductEntity productEntity);
  Future<void> deleteFavoriteProduct(ProductEntity productEntity);

}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  AppDatabase database;
  ProductLocalDataSourceImpl(this.database);

  @override
  Future<List<ProductEntity>> getCartProducts() async {
    return await database.productCartDao.getProducts();
  }
  @override
  Future<List<int>> getCartProductsId() async {
    return await database.productCartDao.getProductsIds();
  }
  @override
  Future<void> insertAllCartProduct(List<ProductEntity> productEntity) async {
    return await database.productCartDao.insertAllProducts(productEntity);
  }
  @override
  Future<void> insertCartProduct(ProductEntity productEntity) async {
    return await database.productCartDao.insertProduct(productEntity);
  }
  @override
  Future<void> deleteCartProduct(ProductEntity productEntity) async {
    return await database.productCartDao.deleteProduct(productEntity);
  }


  @override
  Future<List<ProductEntity>> getProducts() async {
    return await database.productDao.getProducts();
  }
  @override
  Future<List<int>> getProductsId() async {
    return await database.productDao.getProductsIds();
  }
  @override
  Future<void> insertAllProduct(List<ProductEntity> productEntity) async {
    return await database.productDao.insertAllProducts(productEntity);
  }
  @override
  Future<void> insertProduct(ProductEntity productEntity) async {
    return await database.productDao.insertProduct(productEntity);
  }
  @override
  Future<void> deleteProduct(ProductEntity productEntity) async {
    return await database.productDao.deleteProduct(productEntity);
  }


  @override
  Future<void> deleteFavoriteProduct(ProductEntity productEntity) async {
    return await database.productFavoriteDao.deleteProduct(productEntity);
  }
  @override
  Future<List<ProductEntity>> getFavoriteProducts() async {
    return await database.productFavoriteDao.getProducts();
  }
  @override
  Future<List<int>> getFavoriteProductsId() async {
    return await database.productFavoriteDao.getProductsIds();
  }
  @override
  Future<void> insertAllFavoriteProduct(List<ProductEntity> productEntity) async {
    return await database.productFavoriteDao.insertAllProducts(productEntity);
  }
  @override
  Future<void> insertFavoriteProduct(ProductEntity productEntity) async {
    return await database.productFavoriteDao.insertProduct(productEntity);
  }

}