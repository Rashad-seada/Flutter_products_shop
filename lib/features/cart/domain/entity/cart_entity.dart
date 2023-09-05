
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';
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

  // Deserialize from JSON Map
  factory CartEntity.fromJson(Map<String, dynamic> json) {
    return CartEntity(
      id: json['id'] as int?,
      itemId: json['itemId'] as int?,
      unitId: json['unitId'] as int?,
      storeId: json['storeId'] as int?,
      colorId: json['colorId'] as int?,
      sizeId: json['sizeId'] as int?,
      quantity: json['quantity'] as int?,
      note: json['note'] as String?,
    );
  }

  // Serialize to JSON Map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['itemId'] = itemId;
    data['unitId'] = unitId;
    data['storeId'] = storeId;
    data['colorId'] = colorId;
    data['sizeId'] = sizeId;
    data['quantity'] = quantity;
    data['note'] = note;
    return data;
  }



}