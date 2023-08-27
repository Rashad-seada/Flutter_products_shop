import 'package:floor/floor.dart';

import '../../../../features/shop/domain/entity/product_entity.dart';

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

  @Query('DELETE FROM ProductFavoriteEntity')
  Future<void> dropAllFavoriteProducts();
}