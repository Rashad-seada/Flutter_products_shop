// database.dart

// required package imports
import 'dart:async';
import 'package:eng_shop/features/search/domain/entity/recent_search_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


import '../../../features/cart/domain/entity/cart_entity.dart';
import '../../../features/shop/domain/entity/product_entity.dart';
import '../../../features/shop/domain/entity/product_favorite_entity.dart';
import 'dao/cart_dao.dart';
import 'dao/favorite_dao.dart';
import 'dao/product_dao.dart';
import 'dao/search_dao.dart';
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ProductEntity,CartEntity,ProductFavoriteEntity,RecentSearchEntity])
abstract class AppDatabase extends FloorDatabase {

  ProductDao get productDao;
  CartDao get productCartDao;
  ProductFavoriteDao get productFavoriteDao;
  SearchDao get searchDao;
}