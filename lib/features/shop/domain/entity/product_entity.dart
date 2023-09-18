import 'package:floor/floor.dart';


@Entity(tableName: "ProductEntity")
class ProductEntity {

  @PrimaryKey()
  num? id;
  num? fdate;
  num? hfdate;
  num? ftime;
  num? fupdate;
  num? hfupdate;
  num? utime;
  num? fdelete;
  num? hfdelete;
  num? dtime;
  num? userid;
  num? updateUserid;
  num? deleteUserid;
  num? flagnet;
  num? categoryId;
  num? branchId;
  num? storeId;
  num? itemId;
  String? barcode;
  num? munitId;
  num? unitId;
  num? quantityStart;
  num? buyAlertAmount;
  num? orderQntMin;
  num? quantity;
  num? quantityIn;
  num? lastSellQuantity;
  num? lastPurQuantity;
  num? saleQuantity;
  num? purchaseQuantity;
  num? itemEvalId;
  num? terminalPrinterId;
  String? categoryPrntr;
  num? isActive;
  num? isShowPrice;
  num? isDef;
  num? isPublish;
  num? isClose;
  num? isCompound;
  num? isPriceIncludeTax;
  num? isSpecialOffer;
  String? notes;
  String? xfile;
  String? atxt;
  String? etxt;
  num? expirDays;
  num? itemLocationId;
  String? locationCode;
  num? avaPurchasePrice;
  num? priceAddPer;
  num? priceAddValue;
  num? price;
  num? discPer;
  num? discValue;
  num? minPrice;
  num? lastSprice;
  num? lastBprice;
  num? isRetailSale;
  num? setItem;
  num? inUnitId;
  num? quantityUnit;
  num? xgrid;
  String? img;
  num? salesComm;
  num? visits;
  num? netPrice;
  String? adetails;
  String? edetails;
  num? isSerial;
  num? outId;
  num? isSize;
  num? isColor;
  num? isExpiredDate;
  num? avaStartPrice;
  String? barcodesOther;
  num? xtypeId;
  num? countryId;
  num? codeOrg;
  num? codesAlter;
  num? isForsale;


  ProductEntity(
      {this.id,
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
        this.isForsale,
     });

  ProductEntity.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fdate'] = this.fdate;
    data['hfdate'] = this.hfdate;
    data['ftime'] = this.ftime;
    data['fupdate'] = this.fupdate;
    data['hfupdate'] = this.hfupdate;
    data['utime'] = this.utime;
    data['fdelete'] = this.fdelete;
    data['hfdelete'] = this.hfdelete;
    data['dtime'] = this.dtime;
    data['userid'] = this.userid;
    data['update_userid'] = this.updateUserid;
    data['delete_userid'] = this.deleteUserid;
    data['flagnet'] = this.flagnet;
    data['category_id'] = this.categoryId;
    data['branch_id'] = this.branchId;
    data['store_id'] = this.storeId;
    data['item_id'] = this.itemId;
    data['barcode'] = this.barcode;
    data['munit_id'] = this.munitId;
    data['unit_id'] = this.unitId;
    data['quantity_start'] = this.quantityStart;
    data['buy_alert_amount'] = this.buyAlertAmount;
    data['order_qnt_min'] = this.orderQntMin;
    data['quantity'] = this.quantity;
    data['quantity_in'] = this.quantityIn;
    data['last_sell_quantity'] = this.lastSellQuantity;
    data['last_pur_quantity'] = this.lastPurQuantity;
    data['sale_quantity'] = this.saleQuantity;
    data['purchase_quantity'] = this.purchaseQuantity;
    data['item_eval_id'] = this.itemEvalId;
    data['terminal_printer_id'] = this.terminalPrinterId;
    data['category_prntr'] = this.categoryPrntr;
    data['is_active'] = this.isActive;
    data['is_show_price'] = this.isShowPrice;
    data['is_def'] = this.isDef;
    data['is_publish'] = this.isPublish;
    data['is_close'] = this.isClose;
    data['is_compound'] = this.isCompound;
    data['is_price_include_tax'] = this.isPriceIncludeTax;
    data['is_special_offer'] = this.isSpecialOffer;
    data['notes'] = this.notes;
    data['xfile'] = this.xfile;
    data['atxt'] = this.atxt;
    data['etxt'] = this.etxt;
    data['expir_days'] = this.expirDays;
    data['item_location_id'] = this.itemLocationId;
    data['location_code'] = this.locationCode;
    data['ava_purchase_price'] = this.avaPurchasePrice;
    data['price_add_per'] = this.priceAddPer;
    data['price_add_value'] = this.priceAddValue;
    data['price'] = this.price;
    data['disc_per'] = this.discPer;
    data['disc_value'] = this.discValue;
    data['min_price'] = this.minPrice;
    data['last_sprice'] = this.lastSprice;
    data['last_bprice'] = this.lastBprice;
    data['is_retail_sale'] = this.isRetailSale;
    data['set_item'] = this.setItem;
    data['in_unit_id'] = this.inUnitId;
    data['quantity_unit'] = this.quantityUnit;
    data['xgrid'] = this.xgrid;
    data['img'] = this.img;
    data['sales_comm'] = this.salesComm;
    data['visits'] = this.visits;
    data['net_price'] = this.netPrice;
    data['adetails'] = this.adetails;
    data['edetails'] = this.edetails;
    data['is_serial'] = this.isSerial;
    data['out_id'] = this.outId;
    data['is_size'] = this.isSize;
    data['is_color'] = this.isColor;
    data['is_expired_date'] = this.isExpiredDate;
    data['ava_start_price'] = this.avaStartPrice;
    data['barcodes_other'] = this.barcodesOther;
    data['xtype_id'] = this.xtypeId;
    data['country_id'] = this.countryId;
    data['code_org'] = this.codeOrg;
    data['codes_alter'] = this.codesAlter;
    data['is_forsale'] = this.isForsale;
    return data;
  }
}