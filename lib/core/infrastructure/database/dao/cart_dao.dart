import 'package:floor/floor.dart';

import '../../../../features/cart/domain/entity/cart_entity.dart';

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

  @Query('DELETE FROM CartEntity')
  Future<void> dropAllCart();
}