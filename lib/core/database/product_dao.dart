import 'package:floor/floor.dart';

import '../../features/shop/domain/entity/cart_entity.dart';
import '../../features/shop/domain/entity/product_entity.dart';


@dao
abstract class ProductDao {

  @Query('SELECT * FROM ProductEntity')
  Future<List<ProductEntity>> getProducts();

  @Query('SELECT id FROM ProductEntity')
  Future<List<int>> getProductsIds();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllProducts(List<ProductEntity> products);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProduct(ProductEntity person);

  @delete
  Future<void> deleteProduct(ProductEntity person);

  @delete
  Future<void> deleteAllProduct(List<ProductEntity> person);

  @update
  Future<void> updateProduct(ProductEntity products);
}

@dao
abstract class CartDao {

  @Query('SELECT * FROM CartEntity')
  Future<List<CartEntity>> getProducts();

  @Query('SELECT id FROM CartEntity')
  Future<List<int>> getProductsIds();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllProducts(List<CartEntity> products);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProduct(CartEntity person);

  @delete
  Future<void> deleteProduct(CartEntity person);

  @delete
  Future<void> deleteAllProduct(List<CartEntity> person);

  @update
  Future<void> updateProduct(CartEntity products);
}

@dao
abstract class ProductFavoriteDao {

  @Query('SELECT * FROM ProductFavoriteEntity')
  Future<List<ProductEntity>> getProducts();

  @Query('SELECT id FROM ProductFavoriteEntity')
  Future<List<int>> getProductsIds();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllProducts(List<ProductEntity> products);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProduct(ProductEntity person);

  @delete
  Future<void> deleteProduct(ProductEntity person);

  @delete
  Future<void> deleteAllProduct(List<ProductEntity> person);

  @update
  Future<void> updateProduct(ProductEntity products);
}