// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  CartDao? _productCartDaoInstance;

  ProductFavoriteDao? _productFavoriteDaoInstance;

  SearchDao? _searchDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductEntity` (`statusCode` INTEGER, `id` INTEGER, `fdate` INTEGER, `hfdate` INTEGER, `ftime` INTEGER, `fupdate` INTEGER, `hfupdate` INTEGER, `utime` INTEGER, `fdelete` INTEGER, `hfdelete` INTEGER, `dtime` INTEGER, `userid` INTEGER, `updateUserid` INTEGER, `deleteUserid` INTEGER, `flagnet` INTEGER, `categoryId` INTEGER, `branchId` INTEGER, `storeId` INTEGER, `itemId` INTEGER, `barcode` TEXT, `munitId` INTEGER, `unitId` INTEGER, `quantityStart` INTEGER, `buyAlertAmount` INTEGER, `orderQntMin` INTEGER, `quantity` INTEGER, `quantityIn` INTEGER, `lastSellQuantity` INTEGER, `lastPurQuantity` INTEGER, `saleQuantity` INTEGER, `purchaseQuantity` INTEGER, `itemEvalId` INTEGER, `terminalPrinterId` INTEGER, `categoryPrntr` TEXT, `isActive` INTEGER, `isShowPrice` INTEGER, `isDef` INTEGER, `isPublish` INTEGER, `isClose` INTEGER, `isCompound` INTEGER, `isPriceIncludeTax` INTEGER, `isSpecialOffer` INTEGER, `notes` TEXT, `xfile` TEXT, `atxt` TEXT, `etxt` TEXT, `expirDays` INTEGER, `itemLocationId` INTEGER, `locationCode` TEXT, `avaPurchasePrice` INTEGER, `priceAddPer` INTEGER, `priceAddValue` INTEGER, `price` INTEGER, `discPer` INTEGER, `discValue` INTEGER, `minPrice` INTEGER, `lastSprice` INTEGER, `lastBprice` INTEGER, `isRetailSale` INTEGER, `setItem` INTEGER, `inUnitId` INTEGER, `quantityUnit` INTEGER, `xgrid` INTEGER, `img` TEXT, `salesComm` INTEGER, `visits` INTEGER, `netPrice` INTEGER, `adetails` TEXT, `edetails` TEXT, `isSerial` INTEGER, `outId` INTEGER, `isSize` INTEGER, `isColor` INTEGER, `isExpiredDate` INTEGER, `avaStartPrice` INTEGER, `barcodesOther` TEXT, `xtypeId` INTEGER, `countryId` INTEGER, `codeOrg` TEXT, `codesAlter` TEXT, `isForsale` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CartEntity` (`id` INTEGER, `itemId` INTEGER, `unitId` INTEGER, `storeId` INTEGER, `colorId` INTEGER, `sizeId` INTEGER, `quantity` INTEGER, `note` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductFavoriteEntity` (`statusCode` INTEGER, `id` INTEGER, `fdate` INTEGER, `hfdate` INTEGER, `ftime` INTEGER, `fupdate` INTEGER, `hfupdate` INTEGER, `utime` INTEGER, `fdelete` INTEGER, `hfdelete` INTEGER, `dtime` INTEGER, `userid` INTEGER, `updateUserid` INTEGER, `deleteUserid` INTEGER, `flagnet` INTEGER, `categoryId` INTEGER, `branchId` INTEGER, `storeId` INTEGER, `itemId` INTEGER, `barcode` TEXT, `munitId` INTEGER, `unitId` INTEGER, `quantityStart` INTEGER, `buyAlertAmount` INTEGER, `orderQntMin` INTEGER, `quantity` INTEGER, `quantityIn` INTEGER, `lastSellQuantity` INTEGER, `lastPurQuantity` INTEGER, `saleQuantity` INTEGER, `purchaseQuantity` INTEGER, `itemEvalId` INTEGER, `terminalPrinterId` INTEGER, `categoryPrntr` TEXT, `isActive` INTEGER, `isShowPrice` INTEGER, `isDef` INTEGER, `isPublish` INTEGER, `isClose` INTEGER, `isCompound` INTEGER, `isPriceIncludeTax` INTEGER, `isSpecialOffer` INTEGER, `notes` TEXT, `xfile` TEXT, `atxt` TEXT, `etxt` TEXT, `expirDays` INTEGER, `itemLocationId` INTEGER, `locationCode` TEXT, `avaPurchasePrice` INTEGER, `priceAddPer` INTEGER, `priceAddValue` INTEGER, `price` INTEGER, `discPer` INTEGER, `discValue` INTEGER, `minPrice` INTEGER, `lastSprice` INTEGER, `lastBprice` INTEGER, `isRetailSale` INTEGER, `setItem` INTEGER, `inUnitId` INTEGER, `quantityUnit` INTEGER, `xgrid` INTEGER, `img` TEXT, `salesComm` INTEGER, `visits` INTEGER, `netPrice` INTEGER, `adetails` TEXT, `edetails` TEXT, `isSerial` INTEGER, `outId` INTEGER, `isSize` INTEGER, `isColor` INTEGER, `isExpiredDate` INTEGER, `avaStartPrice` INTEGER, `barcodesOther` TEXT, `xtypeId` INTEGER, `countryId` INTEGER, `codeOrg` TEXT, `codesAlter` TEXT, `isForsale` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `RecentSearchEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `searchTerm` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  CartDao get productCartDao {
    return _productCartDaoInstance ??= _$CartDao(database, changeListener);
  }

  @override
  ProductFavoriteDao get productFavoriteDao {
    return _productFavoriteDaoInstance ??=
        _$ProductFavoriteDao(database, changeListener);
  }

  @override
  SearchDao get searchDao {
    return _searchDaoInstance ??= _$SearchDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productEntityInsertionAdapter = InsertionAdapter(
            database,
            'ProductEntity',
            (ProductEntity item) => <String, Object?>{
                  'statusCode': item.statusCode,
                  'id': item.id,
                  'fdate': item.fdate,
                  'hfdate': item.hfdate,
                  'ftime': item.ftime,
                  'fupdate': item.fupdate,
                  'hfupdate': item.hfupdate,
                  'utime': item.utime,
                  'fdelete': item.fdelete,
                  'hfdelete': item.hfdelete,
                  'dtime': item.dtime,
                  'userid': item.userid,
                  'updateUserid': item.updateUserid,
                  'deleteUserid': item.deleteUserid,
                  'flagnet': item.flagnet,
                  'categoryId': item.categoryId,
                  'branchId': item.branchId,
                  'storeId': item.storeId,
                  'itemId': item.itemId,
                  'barcode': item.barcode,
                  'munitId': item.munitId,
                  'unitId': item.unitId,
                  'quantityStart': item.quantityStart,
                  'buyAlertAmount': item.buyAlertAmount,
                  'orderQntMin': item.orderQntMin,
                  'quantity': item.quantity,
                  'quantityIn': item.quantityIn,
                  'lastSellQuantity': item.lastSellQuantity,
                  'lastPurQuantity': item.lastPurQuantity,
                  'saleQuantity': item.saleQuantity,
                  'purchaseQuantity': item.purchaseQuantity,
                  'itemEvalId': item.itemEvalId,
                  'terminalPrinterId': item.terminalPrinterId,
                  'categoryPrntr': item.categoryPrntr,
                  'isActive': item.isActive,
                  'isShowPrice': item.isShowPrice,
                  'isDef': item.isDef,
                  'isPublish': item.isPublish,
                  'isClose': item.isClose,
                  'isCompound': item.isCompound,
                  'isPriceIncludeTax': item.isPriceIncludeTax,
                  'isSpecialOffer': item.isSpecialOffer,
                  'notes': item.notes,
                  'xfile': item.xfile,
                  'atxt': item.atxt,
                  'etxt': item.etxt,
                  'expirDays': item.expirDays,
                  'itemLocationId': item.itemLocationId,
                  'locationCode': item.locationCode,
                  'avaPurchasePrice': item.avaPurchasePrice,
                  'priceAddPer': item.priceAddPer,
                  'priceAddValue': item.priceAddValue,
                  'price': item.price,
                  'discPer': item.discPer,
                  'discValue': item.discValue,
                  'minPrice': item.minPrice,
                  'lastSprice': item.lastSprice,
                  'lastBprice': item.lastBprice,
                  'isRetailSale': item.isRetailSale,
                  'setItem': item.setItem,
                  'inUnitId': item.inUnitId,
                  'quantityUnit': item.quantityUnit,
                  'xgrid': item.xgrid,
                  'img': item.img,
                  'salesComm': item.salesComm,
                  'visits': item.visits,
                  'netPrice': item.netPrice,
                  'adetails': item.adetails,
                  'edetails': item.edetails,
                  'isSerial': item.isSerial,
                  'outId': item.outId,
                  'isSize': item.isSize,
                  'isColor': item.isColor,
                  'isExpiredDate': item.isExpiredDate,
                  'avaStartPrice': item.avaStartPrice,
                  'barcodesOther': item.barcodesOther,
                  'xtypeId': item.xtypeId,
                  'countryId': item.countryId,
                  'codeOrg': item.codeOrg,
                  'codesAlter': item.codesAlter,
                  'isForsale': item.isForsale
                }),
        _productEntityUpdateAdapter = UpdateAdapter(
            database,
            'ProductEntity',
            ['id'],
            (ProductEntity item) => <String, Object?>{
                  'statusCode': item.statusCode,
                  'id': item.id,
                  'fdate': item.fdate,
                  'hfdate': item.hfdate,
                  'ftime': item.ftime,
                  'fupdate': item.fupdate,
                  'hfupdate': item.hfupdate,
                  'utime': item.utime,
                  'fdelete': item.fdelete,
                  'hfdelete': item.hfdelete,
                  'dtime': item.dtime,
                  'userid': item.userid,
                  'updateUserid': item.updateUserid,
                  'deleteUserid': item.deleteUserid,
                  'flagnet': item.flagnet,
                  'categoryId': item.categoryId,
                  'branchId': item.branchId,
                  'storeId': item.storeId,
                  'itemId': item.itemId,
                  'barcode': item.barcode,
                  'munitId': item.munitId,
                  'unitId': item.unitId,
                  'quantityStart': item.quantityStart,
                  'buyAlertAmount': item.buyAlertAmount,
                  'orderQntMin': item.orderQntMin,
                  'quantity': item.quantity,
                  'quantityIn': item.quantityIn,
                  'lastSellQuantity': item.lastSellQuantity,
                  'lastPurQuantity': item.lastPurQuantity,
                  'saleQuantity': item.saleQuantity,
                  'purchaseQuantity': item.purchaseQuantity,
                  'itemEvalId': item.itemEvalId,
                  'terminalPrinterId': item.terminalPrinterId,
                  'categoryPrntr': item.categoryPrntr,
                  'isActive': item.isActive,
                  'isShowPrice': item.isShowPrice,
                  'isDef': item.isDef,
                  'isPublish': item.isPublish,
                  'isClose': item.isClose,
                  'isCompound': item.isCompound,
                  'isPriceIncludeTax': item.isPriceIncludeTax,
                  'isSpecialOffer': item.isSpecialOffer,
                  'notes': item.notes,
                  'xfile': item.xfile,
                  'atxt': item.atxt,
                  'etxt': item.etxt,
                  'expirDays': item.expirDays,
                  'itemLocationId': item.itemLocationId,
                  'locationCode': item.locationCode,
                  'avaPurchasePrice': item.avaPurchasePrice,
                  'priceAddPer': item.priceAddPer,
                  'priceAddValue': item.priceAddValue,
                  'price': item.price,
                  'discPer': item.discPer,
                  'discValue': item.discValue,
                  'minPrice': item.minPrice,
                  'lastSprice': item.lastSprice,
                  'lastBprice': item.lastBprice,
                  'isRetailSale': item.isRetailSale,
                  'setItem': item.setItem,
                  'inUnitId': item.inUnitId,
                  'quantityUnit': item.quantityUnit,
                  'xgrid': item.xgrid,
                  'img': item.img,
                  'salesComm': item.salesComm,
                  'visits': item.visits,
                  'netPrice': item.netPrice,
                  'adetails': item.adetails,
                  'edetails': item.edetails,
                  'isSerial': item.isSerial,
                  'outId': item.outId,
                  'isSize': item.isSize,
                  'isColor': item.isColor,
                  'isExpiredDate': item.isExpiredDate,
                  'avaStartPrice': item.avaStartPrice,
                  'barcodesOther': item.barcodesOther,
                  'xtypeId': item.xtypeId,
                  'countryId': item.countryId,
                  'codeOrg': item.codeOrg,
                  'codesAlter': item.codesAlter,
                  'isForsale': item.isForsale
                }),
        _productEntityDeletionAdapter = DeletionAdapter(
            database,
            'ProductEntity',
            ['id'],
            (ProductEntity item) => <String, Object?>{
                  'statusCode': item.statusCode,
                  'id': item.id,
                  'fdate': item.fdate,
                  'hfdate': item.hfdate,
                  'ftime': item.ftime,
                  'fupdate': item.fupdate,
                  'hfupdate': item.hfupdate,
                  'utime': item.utime,
                  'fdelete': item.fdelete,
                  'hfdelete': item.hfdelete,
                  'dtime': item.dtime,
                  'userid': item.userid,
                  'updateUserid': item.updateUserid,
                  'deleteUserid': item.deleteUserid,
                  'flagnet': item.flagnet,
                  'categoryId': item.categoryId,
                  'branchId': item.branchId,
                  'storeId': item.storeId,
                  'itemId': item.itemId,
                  'barcode': item.barcode,
                  'munitId': item.munitId,
                  'unitId': item.unitId,
                  'quantityStart': item.quantityStart,
                  'buyAlertAmount': item.buyAlertAmount,
                  'orderQntMin': item.orderQntMin,
                  'quantity': item.quantity,
                  'quantityIn': item.quantityIn,
                  'lastSellQuantity': item.lastSellQuantity,
                  'lastPurQuantity': item.lastPurQuantity,
                  'saleQuantity': item.saleQuantity,
                  'purchaseQuantity': item.purchaseQuantity,
                  'itemEvalId': item.itemEvalId,
                  'terminalPrinterId': item.terminalPrinterId,
                  'categoryPrntr': item.categoryPrntr,
                  'isActive': item.isActive,
                  'isShowPrice': item.isShowPrice,
                  'isDef': item.isDef,
                  'isPublish': item.isPublish,
                  'isClose': item.isClose,
                  'isCompound': item.isCompound,
                  'isPriceIncludeTax': item.isPriceIncludeTax,
                  'isSpecialOffer': item.isSpecialOffer,
                  'notes': item.notes,
                  'xfile': item.xfile,
                  'atxt': item.atxt,
                  'etxt': item.etxt,
                  'expirDays': item.expirDays,
                  'itemLocationId': item.itemLocationId,
                  'locationCode': item.locationCode,
                  'avaPurchasePrice': item.avaPurchasePrice,
                  'priceAddPer': item.priceAddPer,
                  'priceAddValue': item.priceAddValue,
                  'price': item.price,
                  'discPer': item.discPer,
                  'discValue': item.discValue,
                  'minPrice': item.minPrice,
                  'lastSprice': item.lastSprice,
                  'lastBprice': item.lastBprice,
                  'isRetailSale': item.isRetailSale,
                  'setItem': item.setItem,
                  'inUnitId': item.inUnitId,
                  'quantityUnit': item.quantityUnit,
                  'xgrid': item.xgrid,
                  'img': item.img,
                  'salesComm': item.salesComm,
                  'visits': item.visits,
                  'netPrice': item.netPrice,
                  'adetails': item.adetails,
                  'edetails': item.edetails,
                  'isSerial': item.isSerial,
                  'outId': item.outId,
                  'isSize': item.isSize,
                  'isColor': item.isColor,
                  'isExpiredDate': item.isExpiredDate,
                  'avaStartPrice': item.avaStartPrice,
                  'barcodesOther': item.barcodesOther,
                  'xtypeId': item.xtypeId,
                  'countryId': item.countryId,
                  'codeOrg': item.codeOrg,
                  'codesAlter': item.codesAlter,
                  'isForsale': item.isForsale
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductEntity> _productEntityInsertionAdapter;

  final UpdateAdapter<ProductEntity> _productEntityUpdateAdapter;

  final DeletionAdapter<ProductEntity> _productEntityDeletionAdapter;

  @override
  Future<List<ProductEntity>> getProducts() async {
    return _queryAdapter.queryList('SELECT * FROM ProductEntity',
        mapper: (Map<String, Object?> row) => ProductEntity(
            id: row['id'] as int?,
            statusCode: row['statusCode'] as int?,
            fdate: row['fdate'] as int?,
            hfdate: row['hfdate'] as int?,
            ftime: row['ftime'] as int?,
            fupdate: row['fupdate'] as int?,
            hfupdate: row['hfupdate'] as int?,
            utime: row['utime'] as int?,
            fdelete: row['fdelete'] as int?,
            hfdelete: row['hfdelete'] as int?,
            dtime: row['dtime'] as int?,
            userid: row['userid'] as int?,
            updateUserid: row['updateUserid'] as int?,
            deleteUserid: row['deleteUserid'] as int?,
            flagnet: row['flagnet'] as int?,
            categoryId: row['categoryId'] as int?,
            branchId: row['branchId'] as int?,
            storeId: row['storeId'] as int?,
            itemId: row['itemId'] as int?,
            barcode: row['barcode'] as String?,
            munitId: row['munitId'] as int?,
            unitId: row['unitId'] as int?,
            quantityStart: row['quantityStart'] as int?,
            buyAlertAmount: row['buyAlertAmount'] as int?,
            orderQntMin: row['orderQntMin'] as int?,
            quantity: row['quantity'] as int?,
            quantityIn: row['quantityIn'] as int?,
            lastSellQuantity: row['lastSellQuantity'] as int?,
            lastPurQuantity: row['lastPurQuantity'] as int?,
            saleQuantity: row['saleQuantity'] as int?,
            purchaseQuantity: row['purchaseQuantity'] as int?,
            itemEvalId: row['itemEvalId'] as int?,
            terminalPrinterId: row['terminalPrinterId'] as int?,
            categoryPrntr: row['categoryPrntr'] as String?,
            isActive: row['isActive'] as int?,
            isShowPrice: row['isShowPrice'] as int?,
            isDef: row['isDef'] as int?,
            isPublish: row['isPublish'] as int?,
            isClose: row['isClose'] as int?,
            isCompound: row['isCompound'] as int?,
            isPriceIncludeTax: row['isPriceIncludeTax'] as int?,
            isSpecialOffer: row['isSpecialOffer'] as int?,
            notes: row['notes'] as String?,
            xfile: row['xfile'] as String?,
            atxt: row['atxt'] as String?,
            etxt: row['etxt'] as String?,
            expirDays: row['expirDays'] as int?,
            itemLocationId: row['itemLocationId'] as int?,
            locationCode: row['locationCode'] as String?,
            avaPurchasePrice: row['avaPurchasePrice'] as int?,
            priceAddPer: row['priceAddPer'] as int?,
            priceAddValue: row['priceAddValue'] as int?,
            price: row['price'] as int?,
            discPer: row['discPer'] as int?,
            discValue: row['discValue'] as int?,
            minPrice: row['minPrice'] as int?,
            lastSprice: row['lastSprice'] as int?,
            lastBprice: row['lastBprice'] as int?,
            isRetailSale: row['isRetailSale'] as int?,
            setItem: row['setItem'] as int?,
            inUnitId: row['inUnitId'] as int?,
            quantityUnit: row['quantityUnit'] as int?,
            xgrid: row['xgrid'] as int?,
            img: row['img'] as String?,
            salesComm: row['salesComm'] as int?,
            visits: row['visits'] as int?,
            netPrice: row['netPrice'] as int?,
            adetails: row['adetails'] as String?,
            edetails: row['edetails'] as String?,
            isSerial: row['isSerial'] as int?,
            outId: row['outId'] as int?,
            isSize: row['isSize'] as int?,
            isColor: row['isColor'] as int?,
            isExpiredDate: row['isExpiredDate'] as int?,
            avaStartPrice: row['avaStartPrice'] as int?,
            barcodesOther: row['barcodesOther'] as String?,
            xtypeId: row['xtypeId'] as int?,
            countryId: row['countryId'] as int?,
            codeOrg: row['codeOrg'] as String?,
            codesAlter: row['codesAlter'] as String?,
            isForsale: row['isForsale'] as int?));
  }

  @override
  Future<List<int>> getProductsIds() async {
    return _queryAdapter.queryList('SELECT id FROM ProductEntity',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertAllProducts(List<ProductEntity> products) async {
    await _productEntityInsertionAdapter.insertList(
        products, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertProduct(ProductEntity person) async {
    await _productEntityInsertionAdapter.insert(
        person, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateProduct(ProductEntity products) async {
    await _productEntityUpdateAdapter.update(
        products, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProduct(ProductEntity person) async {
    await _productEntityDeletionAdapter.delete(person);
  }

  @override
  Future<void> deleteAllProduct(List<ProductEntity> person) async {
    await _productEntityDeletionAdapter.deleteList(person);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _cartEntityInsertionAdapter = InsertionAdapter(
            database,
            'CartEntity',
            (CartEntity item) => <String, Object?>{
                  'id': item.id,
                  'itemId': item.itemId,
                  'unitId': item.unitId,
                  'storeId': item.storeId,
                  'colorId': item.colorId,
                  'sizeId': item.sizeId,
                  'quantity': item.quantity,
                  'note': item.note
                }),
        _cartEntityUpdateAdapter = UpdateAdapter(
            database,
            'CartEntity',
            ['id'],
            (CartEntity item) => <String, Object?>{
                  'id': item.id,
                  'itemId': item.itemId,
                  'unitId': item.unitId,
                  'storeId': item.storeId,
                  'colorId': item.colorId,
                  'sizeId': item.sizeId,
                  'quantity': item.quantity,
                  'note': item.note
                }),
        _cartEntityDeletionAdapter = DeletionAdapter(
            database,
            'CartEntity',
            ['id'],
            (CartEntity item) => <String, Object?>{
                  'id': item.id,
                  'itemId': item.itemId,
                  'unitId': item.unitId,
                  'storeId': item.storeId,
                  'colorId': item.colorId,
                  'sizeId': item.sizeId,
                  'quantity': item.quantity,
                  'note': item.note
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CartEntity> _cartEntityInsertionAdapter;

  final UpdateAdapter<CartEntity> _cartEntityUpdateAdapter;

  final DeletionAdapter<CartEntity> _cartEntityDeletionAdapter;

  @override
  Future<List<CartEntity>> getProducts() async {
    return _queryAdapter.queryList('SELECT * FROM CartEntity',
        mapper: (Map<String, Object?> row) => CartEntity(
            id: row['id'] as int?,
            itemId: row['itemId'] as int?,
            unitId: row['unitId'] as int?,
            storeId: row['storeId'] as int?,
            colorId: row['colorId'] as int?,
            sizeId: row['sizeId'] as int?,
            quantity: row['quantity'] as int?,
            note: row['note'] as String?));
  }

  @override
  Future<List<int>> getProductsIds() async {
    return _queryAdapter.queryList('SELECT id FROM CartEntity',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertAllProducts(List<CartEntity> products) async {
    await _cartEntityInsertionAdapter.insertList(
        products, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertProduct(CartEntity person) async {
    await _cartEntityInsertionAdapter.insert(
        person, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateProduct(CartEntity products) async {
    await _cartEntityUpdateAdapter.update(products, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProduct(CartEntity person) async {
    await _cartEntityDeletionAdapter.delete(person);
  }

  @override
  Future<void> deleteAllProduct(List<CartEntity> person) async {
    await _cartEntityDeletionAdapter.deleteList(person);
  }
}

class _$ProductFavoriteDao extends ProductFavoriteDao {
  _$ProductFavoriteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productEntityInsertionAdapter = InsertionAdapter(
            database,
            'ProductEntity',
            (ProductEntity item) => <String, Object?>{
                  'statusCode': item.statusCode,
                  'id': item.id,
                  'fdate': item.fdate,
                  'hfdate': item.hfdate,
                  'ftime': item.ftime,
                  'fupdate': item.fupdate,
                  'hfupdate': item.hfupdate,
                  'utime': item.utime,
                  'fdelete': item.fdelete,
                  'hfdelete': item.hfdelete,
                  'dtime': item.dtime,
                  'userid': item.userid,
                  'updateUserid': item.updateUserid,
                  'deleteUserid': item.deleteUserid,
                  'flagnet': item.flagnet,
                  'categoryId': item.categoryId,
                  'branchId': item.branchId,
                  'storeId': item.storeId,
                  'itemId': item.itemId,
                  'barcode': item.barcode,
                  'munitId': item.munitId,
                  'unitId': item.unitId,
                  'quantityStart': item.quantityStart,
                  'buyAlertAmount': item.buyAlertAmount,
                  'orderQntMin': item.orderQntMin,
                  'quantity': item.quantity,
                  'quantityIn': item.quantityIn,
                  'lastSellQuantity': item.lastSellQuantity,
                  'lastPurQuantity': item.lastPurQuantity,
                  'saleQuantity': item.saleQuantity,
                  'purchaseQuantity': item.purchaseQuantity,
                  'itemEvalId': item.itemEvalId,
                  'terminalPrinterId': item.terminalPrinterId,
                  'categoryPrntr': item.categoryPrntr,
                  'isActive': item.isActive,
                  'isShowPrice': item.isShowPrice,
                  'isDef': item.isDef,
                  'isPublish': item.isPublish,
                  'isClose': item.isClose,
                  'isCompound': item.isCompound,
                  'isPriceIncludeTax': item.isPriceIncludeTax,
                  'isSpecialOffer': item.isSpecialOffer,
                  'notes': item.notes,
                  'xfile': item.xfile,
                  'atxt': item.atxt,
                  'etxt': item.etxt,
                  'expirDays': item.expirDays,
                  'itemLocationId': item.itemLocationId,
                  'locationCode': item.locationCode,
                  'avaPurchasePrice': item.avaPurchasePrice,
                  'priceAddPer': item.priceAddPer,
                  'priceAddValue': item.priceAddValue,
                  'price': item.price,
                  'discPer': item.discPer,
                  'discValue': item.discValue,
                  'minPrice': item.minPrice,
                  'lastSprice': item.lastSprice,
                  'lastBprice': item.lastBprice,
                  'isRetailSale': item.isRetailSale,
                  'setItem': item.setItem,
                  'inUnitId': item.inUnitId,
                  'quantityUnit': item.quantityUnit,
                  'xgrid': item.xgrid,
                  'img': item.img,
                  'salesComm': item.salesComm,
                  'visits': item.visits,
                  'netPrice': item.netPrice,
                  'adetails': item.adetails,
                  'edetails': item.edetails,
                  'isSerial': item.isSerial,
                  'outId': item.outId,
                  'isSize': item.isSize,
                  'isColor': item.isColor,
                  'isExpiredDate': item.isExpiredDate,
                  'avaStartPrice': item.avaStartPrice,
                  'barcodesOther': item.barcodesOther,
                  'xtypeId': item.xtypeId,
                  'countryId': item.countryId,
                  'codeOrg': item.codeOrg,
                  'codesAlter': item.codesAlter,
                  'isForsale': item.isForsale
                }),
        _productEntityUpdateAdapter = UpdateAdapter(
            database,
            'ProductEntity',
            ['id'],
            (ProductEntity item) => <String, Object?>{
                  'statusCode': item.statusCode,
                  'id': item.id,
                  'fdate': item.fdate,
                  'hfdate': item.hfdate,
                  'ftime': item.ftime,
                  'fupdate': item.fupdate,
                  'hfupdate': item.hfupdate,
                  'utime': item.utime,
                  'fdelete': item.fdelete,
                  'hfdelete': item.hfdelete,
                  'dtime': item.dtime,
                  'userid': item.userid,
                  'updateUserid': item.updateUserid,
                  'deleteUserid': item.deleteUserid,
                  'flagnet': item.flagnet,
                  'categoryId': item.categoryId,
                  'branchId': item.branchId,
                  'storeId': item.storeId,
                  'itemId': item.itemId,
                  'barcode': item.barcode,
                  'munitId': item.munitId,
                  'unitId': item.unitId,
                  'quantityStart': item.quantityStart,
                  'buyAlertAmount': item.buyAlertAmount,
                  'orderQntMin': item.orderQntMin,
                  'quantity': item.quantity,
                  'quantityIn': item.quantityIn,
                  'lastSellQuantity': item.lastSellQuantity,
                  'lastPurQuantity': item.lastPurQuantity,
                  'saleQuantity': item.saleQuantity,
                  'purchaseQuantity': item.purchaseQuantity,
                  'itemEvalId': item.itemEvalId,
                  'terminalPrinterId': item.terminalPrinterId,
                  'categoryPrntr': item.categoryPrntr,
                  'isActive': item.isActive,
                  'isShowPrice': item.isShowPrice,
                  'isDef': item.isDef,
                  'isPublish': item.isPublish,
                  'isClose': item.isClose,
                  'isCompound': item.isCompound,
                  'isPriceIncludeTax': item.isPriceIncludeTax,
                  'isSpecialOffer': item.isSpecialOffer,
                  'notes': item.notes,
                  'xfile': item.xfile,
                  'atxt': item.atxt,
                  'etxt': item.etxt,
                  'expirDays': item.expirDays,
                  'itemLocationId': item.itemLocationId,
                  'locationCode': item.locationCode,
                  'avaPurchasePrice': item.avaPurchasePrice,
                  'priceAddPer': item.priceAddPer,
                  'priceAddValue': item.priceAddValue,
                  'price': item.price,
                  'discPer': item.discPer,
                  'discValue': item.discValue,
                  'minPrice': item.minPrice,
                  'lastSprice': item.lastSprice,
                  'lastBprice': item.lastBprice,
                  'isRetailSale': item.isRetailSale,
                  'setItem': item.setItem,
                  'inUnitId': item.inUnitId,
                  'quantityUnit': item.quantityUnit,
                  'xgrid': item.xgrid,
                  'img': item.img,
                  'salesComm': item.salesComm,
                  'visits': item.visits,
                  'netPrice': item.netPrice,
                  'adetails': item.adetails,
                  'edetails': item.edetails,
                  'isSerial': item.isSerial,
                  'outId': item.outId,
                  'isSize': item.isSize,
                  'isColor': item.isColor,
                  'isExpiredDate': item.isExpiredDate,
                  'avaStartPrice': item.avaStartPrice,
                  'barcodesOther': item.barcodesOther,
                  'xtypeId': item.xtypeId,
                  'countryId': item.countryId,
                  'codeOrg': item.codeOrg,
                  'codesAlter': item.codesAlter,
                  'isForsale': item.isForsale
                }),
        _productEntityDeletionAdapter = DeletionAdapter(
            database,
            'ProductEntity',
            ['id'],
            (ProductEntity item) => <String, Object?>{
                  'statusCode': item.statusCode,
                  'id': item.id,
                  'fdate': item.fdate,
                  'hfdate': item.hfdate,
                  'ftime': item.ftime,
                  'fupdate': item.fupdate,
                  'hfupdate': item.hfupdate,
                  'utime': item.utime,
                  'fdelete': item.fdelete,
                  'hfdelete': item.hfdelete,
                  'dtime': item.dtime,
                  'userid': item.userid,
                  'updateUserid': item.updateUserid,
                  'deleteUserid': item.deleteUserid,
                  'flagnet': item.flagnet,
                  'categoryId': item.categoryId,
                  'branchId': item.branchId,
                  'storeId': item.storeId,
                  'itemId': item.itemId,
                  'barcode': item.barcode,
                  'munitId': item.munitId,
                  'unitId': item.unitId,
                  'quantityStart': item.quantityStart,
                  'buyAlertAmount': item.buyAlertAmount,
                  'orderQntMin': item.orderQntMin,
                  'quantity': item.quantity,
                  'quantityIn': item.quantityIn,
                  'lastSellQuantity': item.lastSellQuantity,
                  'lastPurQuantity': item.lastPurQuantity,
                  'saleQuantity': item.saleQuantity,
                  'purchaseQuantity': item.purchaseQuantity,
                  'itemEvalId': item.itemEvalId,
                  'terminalPrinterId': item.terminalPrinterId,
                  'categoryPrntr': item.categoryPrntr,
                  'isActive': item.isActive,
                  'isShowPrice': item.isShowPrice,
                  'isDef': item.isDef,
                  'isPublish': item.isPublish,
                  'isClose': item.isClose,
                  'isCompound': item.isCompound,
                  'isPriceIncludeTax': item.isPriceIncludeTax,
                  'isSpecialOffer': item.isSpecialOffer,
                  'notes': item.notes,
                  'xfile': item.xfile,
                  'atxt': item.atxt,
                  'etxt': item.etxt,
                  'expirDays': item.expirDays,
                  'itemLocationId': item.itemLocationId,
                  'locationCode': item.locationCode,
                  'avaPurchasePrice': item.avaPurchasePrice,
                  'priceAddPer': item.priceAddPer,
                  'priceAddValue': item.priceAddValue,
                  'price': item.price,
                  'discPer': item.discPer,
                  'discValue': item.discValue,
                  'minPrice': item.minPrice,
                  'lastSprice': item.lastSprice,
                  'lastBprice': item.lastBprice,
                  'isRetailSale': item.isRetailSale,
                  'setItem': item.setItem,
                  'inUnitId': item.inUnitId,
                  'quantityUnit': item.quantityUnit,
                  'xgrid': item.xgrid,
                  'img': item.img,
                  'salesComm': item.salesComm,
                  'visits': item.visits,
                  'netPrice': item.netPrice,
                  'adetails': item.adetails,
                  'edetails': item.edetails,
                  'isSerial': item.isSerial,
                  'outId': item.outId,
                  'isSize': item.isSize,
                  'isColor': item.isColor,
                  'isExpiredDate': item.isExpiredDate,
                  'avaStartPrice': item.avaStartPrice,
                  'barcodesOther': item.barcodesOther,
                  'xtypeId': item.xtypeId,
                  'countryId': item.countryId,
                  'codeOrg': item.codeOrg,
                  'codesAlter': item.codesAlter,
                  'isForsale': item.isForsale
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductEntity> _productEntityInsertionAdapter;

  final UpdateAdapter<ProductEntity> _productEntityUpdateAdapter;

  final DeletionAdapter<ProductEntity> _productEntityDeletionAdapter;

  @override
  Future<List<ProductEntity>> getProducts() async {
    return _queryAdapter.queryList('SELECT * FROM ProductFavoriteEntity',
        mapper: (Map<String, Object?> row) => ProductEntity(
            id: row['id'] as int?,
            statusCode: row['statusCode'] as int?,
            fdate: row['fdate'] as int?,
            hfdate: row['hfdate'] as int?,
            ftime: row['ftime'] as int?,
            fupdate: row['fupdate'] as int?,
            hfupdate: row['hfupdate'] as int?,
            utime: row['utime'] as int?,
            fdelete: row['fdelete'] as int?,
            hfdelete: row['hfdelete'] as int?,
            dtime: row['dtime'] as int?,
            userid: row['userid'] as int?,
            updateUserid: row['updateUserid'] as int?,
            deleteUserid: row['deleteUserid'] as int?,
            flagnet: row['flagnet'] as int?,
            categoryId: row['categoryId'] as int?,
            branchId: row['branchId'] as int?,
            storeId: row['storeId'] as int?,
            itemId: row['itemId'] as int?,
            barcode: row['barcode'] as String?,
            munitId: row['munitId'] as int?,
            unitId: row['unitId'] as int?,
            quantityStart: row['quantityStart'] as int?,
            buyAlertAmount: row['buyAlertAmount'] as int?,
            orderQntMin: row['orderQntMin'] as int?,
            quantity: row['quantity'] as int?,
            quantityIn: row['quantityIn'] as int?,
            lastSellQuantity: row['lastSellQuantity'] as int?,
            lastPurQuantity: row['lastPurQuantity'] as int?,
            saleQuantity: row['saleQuantity'] as int?,
            purchaseQuantity: row['purchaseQuantity'] as int?,
            itemEvalId: row['itemEvalId'] as int?,
            terminalPrinterId: row['terminalPrinterId'] as int?,
            categoryPrntr: row['categoryPrntr'] as String?,
            isActive: row['isActive'] as int?,
            isShowPrice: row['isShowPrice'] as int?,
            isDef: row['isDef'] as int?,
            isPublish: row['isPublish'] as int?,
            isClose: row['isClose'] as int?,
            isCompound: row['isCompound'] as int?,
            isPriceIncludeTax: row['isPriceIncludeTax'] as int?,
            isSpecialOffer: row['isSpecialOffer'] as int?,
            notes: row['notes'] as String?,
            xfile: row['xfile'] as String?,
            atxt: row['atxt'] as String?,
            etxt: row['etxt'] as String?,
            expirDays: row['expirDays'] as int?,
            itemLocationId: row['itemLocationId'] as int?,
            locationCode: row['locationCode'] as String?,
            avaPurchasePrice: row['avaPurchasePrice'] as int?,
            priceAddPer: row['priceAddPer'] as int?,
            priceAddValue: row['priceAddValue'] as int?,
            price: row['price'] as int?,
            discPer: row['discPer'] as int?,
            discValue: row['discValue'] as int?,
            minPrice: row['minPrice'] as int?,
            lastSprice: row['lastSprice'] as int?,
            lastBprice: row['lastBprice'] as int?,
            isRetailSale: row['isRetailSale'] as int?,
            setItem: row['setItem'] as int?,
            inUnitId: row['inUnitId'] as int?,
            quantityUnit: row['quantityUnit'] as int?,
            xgrid: row['xgrid'] as int?,
            img: row['img'] as String?,
            salesComm: row['salesComm'] as int?,
            visits: row['visits'] as int?,
            netPrice: row['netPrice'] as int?,
            adetails: row['adetails'] as String?,
            edetails: row['edetails'] as String?,
            isSerial: row['isSerial'] as int?,
            outId: row['outId'] as int?,
            isSize: row['isSize'] as int?,
            isColor: row['isColor'] as int?,
            isExpiredDate: row['isExpiredDate'] as int?,
            avaStartPrice: row['avaStartPrice'] as int?,
            barcodesOther: row['barcodesOther'] as String?,
            xtypeId: row['xtypeId'] as int?,
            countryId: row['countryId'] as int?,
            codeOrg: row['codeOrg'] as String?,
            codesAlter: row['codesAlter'] as String?,
            isForsale: row['isForsale'] as int?));
  }

  @override
  Future<List<int>> getProductsIds() async {
    return _queryAdapter.queryList('SELECT id FROM ProductFavoriteEntity',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertAllProducts(List<ProductEntity> products) async {
    await _productEntityInsertionAdapter.insertList(
        products, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertProduct(ProductEntity person) async {
    await _productEntityInsertionAdapter.insert(
        person, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateProduct(ProductEntity products) async {
    await _productEntityUpdateAdapter.update(
        products, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProduct(ProductEntity person) async {
    await _productEntityDeletionAdapter.delete(person);
  }

  @override
  Future<void> deleteAllProduct(List<ProductEntity> person) async {
    await _productEntityDeletionAdapter.deleteList(person);
  }
}

class _$SearchDao extends SearchDao {
  _$SearchDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _recentSearchEntityInsertionAdapter = InsertionAdapter(
            database,
            'RecentSearchEntity',
            (RecentSearchEntity item) => <String, Object?>{
                  'id': item.id,
                  'searchTerm': item.searchTerm
                }),
        _recentSearchEntityDeletionAdapter = DeletionAdapter(
            database,
            'RecentSearchEntity',
            ['id'],
            (RecentSearchEntity item) => <String, Object?>{
                  'id': item.id,
                  'searchTerm': item.searchTerm
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RecentSearchEntity>
      _recentSearchEntityInsertionAdapter;

  final DeletionAdapter<RecentSearchEntity> _recentSearchEntityDeletionAdapter;

  @override
  Future<List<RecentSearchEntity>> getAllRecentSearch() async {
    return _queryAdapter.queryList('SELECT * FROM RecentSearchEntity',
        mapper: (Map<String, Object?> row) =>
            RecentSearchEntity(row['id'] as int, row['searchTerm'] as String));
  }

  @override
  Future<void> dropAllRecentSearch() async {
    await _queryAdapter.queryNoReturn('DROP TABLE RecentSearchEntity');
  }

  @override
  Future<void> insertRecentSearch(RecentSearchEntity recentSearchEntity) async {
    await _recentSearchEntityInsertionAdapter.insert(
        recentSearchEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteRecentSearch(RecentSearchEntity recentSearchEntity) async {
    await _recentSearchEntityDeletionAdapter.delete(recentSearchEntity);
  }
}
