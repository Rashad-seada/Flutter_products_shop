// database.dart

// required package imports
import 'dart:async';
import 'package:eng_shop/features/main_feature/domain/entity/cart_entity.dart';
import 'package:eng_shop/features/main_feature/domain/entity/product_entity.dart';
import 'package:eng_shop/features/main_feature/domain/entity/product_favorite_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'product_dao.dart';
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ProductEntity,CartEntity,ProductFavoriteEntity])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get productDao;
  CartDao get productCartDao;
  ProductFavoriteDao get productFavoriteDao;

}