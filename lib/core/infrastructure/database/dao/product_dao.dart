import 'package:floor/floor.dart';

import '../../../../features/cart/domain/entity/cart_entity.dart';
import '../../../../features/shop/domain/entity/product_entity.dart';



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

  @Query('DELETE FROM ProductEntity')
  Future<void> dropAllProducts();
}



