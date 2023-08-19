
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';
import 'package:floor/floor.dart';


@Entity(tableName: "CartEntity")
class CartEntity{
  @primaryKey
  int? id;
  int? itemId;
  int? unitId;
  int? storeId;
  int? colorId;
  int? sizeId;
  int? quantity;
  String? note;

  CartEntity(
      {
      this.id,
      this.itemId,
      this.unitId,
      this.storeId,
      this.colorId,
      this.sizeId,
      this.quantity,
      this.note
      });

  CartEntity.fromProduct(ProductEntity productEntity){
    id = int.parse("${productEntity.id}");
    itemId = int.parse("${productEntity.itemId}");
    unitId = int.parse("${productEntity.unitId}");
    storeId = int.parse("${productEntity.storeId}");
    colorId = 0;
    sizeId = 0;
    quantity = 1;
    note = "";
  }



}