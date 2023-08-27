
import '../../../../../core/error/exception.dart';
import '../../../../../core/infrastructure/database/database.dart';
import '../../../domain/entity/product_entity.dart';

abstract class ProductLocalDataSource {


  //products
  Future<List<ProductEntity>> getProducts();
  Future<List<int>> getProductsId();
  Future<void> insertAllProduct(List<ProductEntity> productEntity);
  Future<void> insertProduct(ProductEntity productEntity);
  Future<void> deleteProduct(ProductEntity productEntity);
  Future<void> updateProduct(ProductEntity productEntity);
  Future<void> dropAllProducts();


  //favorite products
  Future<List<ProductEntity>> getFavoriteProducts();
  Future<List<int>> getFavoriteProductsId();
  Future<void> insertAllFavoriteProduct(List<ProductEntity> productEntity);
  Future<void> insertFavoriteProduct(ProductEntity productEntity);
  Future<void> deleteFavoriteProduct(ProductEntity productEntity);
  Future<void> updateFavoriteProduct(ProductEntity productEntity);
  Future<void> dropAllFavoriteProducts();

}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  AppDatabase database;
  ProductLocalDataSourceImpl(this.database);




  @override
  Future<List<ProductEntity>> getProducts() async {
    try{
      return await database.productDao.getProducts();

    } catch (e) {
      throw LocalDataException();
    }
  }
  @override
  Future<List<int>> getProductsId() async {
    try{
      return await database.productDao.getProductsIds();

    } catch (e) {
      throw LocalDataException();
    }
  }
  @override
  Future<void> insertAllProduct(List<ProductEntity> productEntity) async {
    try{
      return await database.productDao.insertAllProducts(productEntity);

    } catch (e) {
      throw LocalDataException();
    }
  }
  @override
  Future<void> insertProduct(ProductEntity productEntity) async {
    try{
      return await database.productDao.insertProduct(productEntity);

    } catch (e) {
      throw LocalDataException();
    }
  }
  @override
  Future<void> deleteProduct(ProductEntity productEntity) async {
    try{
      return await database.productDao.deleteProduct(productEntity);

    } catch (e) {
      throw LocalDataException();
    }
  }


  @override
  Future<void> deleteFavoriteProduct(ProductEntity productEntity) async {
    try{
      return await database.productFavoriteDao.deleteProduct(productEntity);

    } catch (e) {
      throw LocalDataException();
    }
  }
  @override
  Future<List<ProductEntity>> getFavoriteProducts() async {
    try{
      return await database.productFavoriteDao.getProducts();

    } catch (e) {
      throw LocalDataException();
    }
  }
  @override
  Future<List<int>> getFavoriteProductsId() async {
    try{
      return await database.productFavoriteDao.getProductsIds();

    } catch (e) {
      throw LocalDataException();
    }
  }
  @override
  Future<void> insertAllFavoriteProduct(List<ProductEntity> productEntity) async {
    try{
      return await database.productFavoriteDao.insertAllProducts(productEntity);

    } catch (e) {
      throw LocalDataException();
    }
  }
  @override
  Future<void> insertFavoriteProduct(ProductEntity productEntity) async {
    try{
      return await database.productFavoriteDao.insertProduct(productEntity);

    } catch (e) {
      throw LocalDataException();
    }
  }



  @override
  Future<void> updateFavoriteProduct(ProductEntity productEntity) async {
    try{
      return await database.productFavoriteDao.updateProduct(productEntity);

    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> updateProduct(ProductEntity productEntity) async {
    try{
      return await database.productDao.updateProduct(productEntity);

    } catch (e) {
      throw LocalDataException();
    }
  }



  @override
  Future<void> dropAllFavoriteProducts() async {
    try{
      await database.productFavoriteDao.dropAllFavoriteProducts();
    } catch (e) {
      throw LocalDataException();
    }
  }

  @override
  Future<void> dropAllProducts() async {
    try{
      await database.productDao.dropAllProducts();
    } catch (e) {
      throw LocalDataException();
    }
  }

}