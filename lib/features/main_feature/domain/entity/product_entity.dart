import 'package:floor/floor.dart';

@Entity(tableName: "ProductEntity")
class ProductEntity {
  int? statusCode;

  @primaryKey
  int? id;
  int? fdate;
  int? hfdate;
  int? ftime;
  int? fupdate;
  int? hfupdate;
  int? utime;
  int? fdelete;
  int? hfdelete;
  int? dtime;
  int? userid;
  int? updateUserid;
  int? deleteUserid;
  int? flagnet;
  int? categoryId;
  int? branchId;
  int? storeId;
  int? itemId;
  String? barcode;
  int? munitId;
  int? unitId;
  int? quantityStart;
  int? buyAlertAmount;
  int? orderQntMin;
  int? quantity;
  int? quantityIn;
  int? lastSellQuantity;
  int? lastPurQuantity;
  int? saleQuantity;
  int? purchaseQuantity;
  int? itemEvalId;
  int? terminalPrinterId;
  String? categoryPrntr;
  int? isActive;
  int? isShowPrice;
  int? isDef;
  int? isPublish;
  int? isClose;
  int? isCompound;
  int? isPriceIncludeTax;
  int? isSpecialOffer;
  String? notes;
  String? xfile;
  String? atxt;
  String? etxt;
  int? expirDays;
  int? itemLocationId;
  String? locationCode;
  int? avaPurchasePrice;
  int? priceAddPer;
  int? priceAddValue;
  int? price;
  int? discPer;
  int? discValue;
  int? minPrice;
  int? lastSprice;
  int? lastBprice;
  int? isRetailSale;
  int? setItem;
  int? inUnitId;
  int? quantityUnit;
  int? xgrid;
  String? img;
  int? salesComm;
  int? visits;
  int? netPrice;
  String? adetails;
  String? edetails;
  int? isSerial;
  int? outId;
  int? isSize;
  int? isColor;
  int? isExpiredDate;
  int? avaStartPrice;
  String? barcodesOther;
  int? xtypeId;
  int? countryId;
  String? codeOrg;
  String? codesAlter;
  int? isForsale;

  ProductEntity(
      {
        this.statusCode,
        this.id,
        this.fdate,
        this.hfdate,
        this.ftime,
        this.fupdate,
        this.hfupdate,
        this.utime,
        this.fdelete,
        this.hfdelete,
        this.dtime,
        this.userid,
        this.updateUserid,
        this.deleteUserid,
        this.flagnet,
        this.categoryId,
        this.branchId,
        this.storeId,
        this.itemId,
        this.barcode,
        this.munitId,
        this.unitId,
        this.quantityStart,
        this.buyAlertAmount,
        this.orderQntMin,
        this.quantity,
        this.quantityIn,
        this.lastSellQuantity,
        this.lastPurQuantity,
        this.saleQuantity,
        this.purchaseQuantity,
        this.itemEvalId,
        this.terminalPrinterId,
        this.categoryPrntr,
        this.isActive,
        this.isShowPrice,
        this.isDef,
        this.isPublish,
        this.isClose,
        this.isCompound,
        this.isPriceIncludeTax,
        this.isSpecialOffer,
        this.notes,
        this.xfile,
        this.atxt,
        this.etxt,
        this.expirDays,
        this.itemLocationId,
        this.locationCode,
        this.avaPurchasePrice,
        this.priceAddPer,
        this.priceAddValue,
        this.price,
        this.discPer,
        this.discValue,
        this.minPrice,
        this.lastSprice,
        this.lastBprice,
        this.isRetailSale,
        this.setItem,
        this.inUnitId,
        this.quantityUnit,
        this.xgrid,
        this.img,
        this.salesComm,
        this.visits,
        this.netPrice,
        this.adetails,
        this.edetails,
        this.isSerial,
        this.outId,
        this.isSize,
        this.isColor,
        this.isExpiredDate,
        this.avaStartPrice,
        this.barcodesOther,
        this.xtypeId,
        this.countryId,
        this.codeOrg,
        this.codesAlter,
        this.isForsale});

  ProductEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
    id = json['id'];
    fdate = json['fdate'];
    hfdate = json['hfdate'];
    ftime = json['ftime'];
    fupdate = json['fupdate'];
    hfupdate = json['hfupdate'];
    utime = json['utime'];
    fdelete = json['fdelete'];
    hfdelete = json['hfdelete'];
    dtime = json['dtime'];
    userid = json['userid'];
    updateUserid = json['update_userid'];
    deleteUserid = json['delete_userid'];
    flagnet = json['flagnet'];
    categoryId = json['category_id'];
    branchId = json['branch_id'];
    storeId = json['store_id'];
    itemId = json['item_id'];
    barcode = json['barcode'];
    munitId = json['munit_id'];
    unitId = json['unit_id'];
    quantityStart = json['quantity_start'];
    buyAlertAmount = json['buy_alert_amount'];
    orderQntMin = json['order_qnt_min'];
    quantity = json['quantity'];
    quantityIn = json['quantity_in'];
    lastSellQuantity = json['last_sell_quantity'];
    lastPurQuantity = json['last_pur_quantity'];
    saleQuantity = json['sale_quantity'];
    purchaseQuantity = json['purchase_quantity'];
    itemEvalId = json['item_eval_id'];
    terminalPrinterId = json['terminal_printer_id'];
    categoryPrntr = json['category_prntr'];
    isActive = json['is_active'];
    isShowPrice = json['is_show_price'];
    isDef = json['is_def'];
    isPublish = json['is_publish'];
    isClose = json['is_close'];
    isCompound = json['is_compound'];
    isPriceIncludeTax = json['is_price_include_tax'];
    isSpecialOffer = json['is_special_offer'];
    notes = json['notes'];
    xfile = json['xfile'];
    atxt = json['atxt'];
    etxt = json['etxt'];
    expirDays = json['expir_days'];
    itemLocationId = json['item_location_id'];
    locationCode = json['location_code'];
    avaPurchasePrice = json['ava_purchase_price'];
    priceAddPer = json['price_add_per'];
    priceAddValue = json['price_add_value'];
    price = json['price'];
    discPer = json['disc_per'];
    discValue = json['disc_value'];
    minPrice = json['min_price'];
    lastSprice = json['last_sprice'];
    lastBprice = json['last_bprice'];
    isRetailSale = json['is_retail_sale'];
    setItem = json['set_item'];
    inUnitId = json['in_unit_id'];
    quantityUnit = json['quantity_unit'];
    xgrid = json['xgrid'];
    img = json['img'];
    salesComm = json['sales_comm'];
    visits = json['visits'];
    netPrice = json['net_price'];
    adetails = json['adetails'];
    edetails = json['edetails'];
    isSerial = json['is_serial'];
    outId = json['out_id'];
    isSize = json['is_size'];
    isColor = json['is_color'];
    isExpiredDate = json['is_expired_date'];
    avaStartPrice = json['ava_start_price'];
    barcodesOther = json['barcodes_other'];
    xtypeId = json['xtype_id'];
    countryId = json['country_id'];
    codeOrg = json['code_org'];
    codesAlter = json['codes_alter'];
    isForsale = json['is_forsale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fdate'] = fdate;
    data['hfdate'] = hfdate;
    data['ftime'] = ftime;
    data['fupdate'] = fupdate;
    data['hfupdate'] = hfupdate;
    data['utime'] = utime;
    data['fdelete'] = fdelete;
    data['hfdelete'] = hfdelete;
    data['dtime'] = dtime;
    data['userid'] = userid;
    data['update_userid'] = updateUserid;
    data['delete_userid'] = deleteUserid;
    data['flagnet'] = flagnet;
    data['category_id'] = categoryId;
    data['branch_id'] = branchId;
    data['store_id'] = storeId;
    data['item_id'] = itemId;
    data['barcode'] = barcode;
    data['munit_id'] = munitId;
    data['unit_id'] = unitId;
    data['quantity_start'] = quantityStart;
    data['buy_alert_amount'] = buyAlertAmount;
    data['order_qnt_min'] = orderQntMin;
    data['quantity'] = quantity;
    data['quantity_in'] = quantityIn;
    data['last_sell_quantity'] = lastSellQuantity;
    data['last_pur_quantity'] = lastPurQuantity;
    data['sale_quantity'] = saleQuantity;
    data['purchase_quantity'] = purchaseQuantity;
    data['item_eval_id'] = itemEvalId;
    data['terminal_printer_id'] = terminalPrinterId;
    data['category_prntr'] = categoryPrntr;
    data['is_active'] = isActive;
    data['is_show_price'] = isShowPrice;
    data['is_def'] = isDef;
    data['is_publish'] = isPublish;
    data['is_close'] = isClose;
    data['is_compound'] = isCompound;
    data['is_price_include_tax'] = isPriceIncludeTax;
    data['is_special_offer'] = isSpecialOffer;
    data['notes'] = notes;
    data['xfile'] = xfile;
    data['atxt'] = atxt;
    data['etxt'] = etxt;
    data['expir_days'] = expirDays;
    data['item_location_id'] = itemLocationId;
    data['location_code'] = locationCode;
    data['ava_purchase_price'] = avaPurchasePrice;
    data['price_add_per'] = priceAddPer;
    data['price_add_value'] = priceAddValue;
    data['price'] = price;
    data['disc_per'] = discPer;
    data['disc_value'] = discValue;
    data['min_price'] = minPrice;
    data['last_sprice'] = lastSprice;
    data['last_bprice'] = lastBprice;
    data['is_retail_sale'] = isRetailSale;
    data['set_item'] = setItem;
    data['in_unit_id'] = inUnitId;
    data['quantity_unit'] = quantityUnit;
    data['xgrid'] = xgrid;
    data['img'] = img;
    data['sales_comm'] = salesComm;
    data['visits'] = visits;
    data['net_price'] = netPrice;
    data['adetails'] = adetails;
    data['edetails'] = edetails;
    data['is_serial'] = isSerial;
    data['out_id'] = outId;
    data['is_size'] = isSize;
    data['is_color'] = isColor;
    data['is_expired_date'] = isExpiredDate;
    data['ava_start_price'] = avaStartPrice;
    data['barcodes_other'] = barcodesOther;
    data['xtype_id'] = xtypeId;
    data['country_id'] = countryId;
    data['code_org'] = codeOrg;
    data['codes_alter'] = codesAlter;
    data['is_forsale'] = isForsale;
    return data;
  }
}

