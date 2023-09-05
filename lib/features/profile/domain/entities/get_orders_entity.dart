class GetOrderItemsEntity {
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
  num? storeId;
  num? orderId;
  num? invId;
  num? seq;
  num? quantity;
  num? categoryId;
  num? xtypeId;
  String? barcode;
  num? itemId;
  String? txt;
  num? munitId;
  num? unitId;
  num? remQuantity;
  num? receivedQuantity;
  num? isFinish;
  num? isCancelled;
  String? cancelReason;
  String? notes;
  num? isClose;
  num? branchId;
  num? currencyId;
  num? currencyVal;
  num? unitPrice;
  num? totalPrice;
  num? xdisc;
  num? netAmount;
  num? isPaid;
  num? sizeId;
  num? colorId;
  String? xitemId;
  num? stateId;
  num? outId;
  num? isSalesPart;
  num? dateExpire;
  num? zdate;
  num? vatValue;
  num? vatSalePer;

  GetOrderItemsEntity(
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
        this.storeId,
        this.orderId,
        this.invId,
        this.seq,
        this.quantity,
        this.categoryId,
        this.xtypeId,
        this.barcode,
        this.itemId,
        this.txt,
        this.munitId,
        this.unitId,
        this.remQuantity,
        this.receivedQuantity,
        this.isFinish,
        this.isCancelled,
        this.cancelReason,
        this.notes,
        this.isClose,
        this.branchId,
        this.currencyId,
        this.currencyVal,
        this.unitPrice,
        this.totalPrice,
        this.xdisc,
        this.netAmount,
        this.isPaid,
        this.sizeId,
        this.colorId,
        this.xitemId,
        this.stateId,
        this.outId,
        this.isSalesPart,
        this.dateExpire,
        this.zdate,
        this.vatValue,
        this.vatSalePer});

  GetOrderItemsEntity.fromJson(Map<String, dynamic> json) {
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
    storeId = json['store_id'];
    orderId = json['order_id'];
    invId = json['inv_id'];
    seq = json['seq'];
    quantity = json['quantity'];
    categoryId = json['category_id'];
    xtypeId = json['xtype_id'];
    barcode = json['barcode'];
    itemId = json['item_id'];
    txt = json['txt'];
    munitId = json['munit_id'];
    unitId = json['unit_id'];
    remQuantity = json['rem_quantity'];
    receivedQuantity = json['received_quantity'];
    isFinish = json['is_finish'];
    isCancelled = json['is_cancelled'];
    cancelReason = json['cancel_reason'];
    notes = json['notes'];
    isClose = json['is_close'];
    branchId = json['branch_id'];
    currencyId = json['currency_id'];
    currencyVal = json['currency_val'];
    unitPrice = json['unit_price'];
    totalPrice = json['total_price'];
    xdisc = json['xdisc'];
    netAmount = json['net_amount'];
    isPaid = json['is_paid'];
    sizeId = json['size_id'];
    colorId = json['color_id'];
    xitemId = json['xitem_id'];
    stateId = json['state_id'];
    outId = json['out_id'];
    isSalesPart = json['is_sales_part'];
    dateExpire = json['date_expire'];
    zdate = json['zdate'];
    vatValue = json['vat_value'];
    vatSalePer = json['vat_sale_per'];
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
    data['store_id'] = storeId;
    data['order_id'] = orderId;
    data['inv_id'] = invId;
    data['seq'] = seq;
    data['quantity'] = quantity;
    data['category_id'] = categoryId;
    data['xtype_id'] = xtypeId;
    data['barcode'] = barcode;
    data['item_id'] = itemId;
    data['txt'] = txt;
    data['munit_id'] = munitId;
    data['unit_id'] = unitId;
    data['rem_quantity'] = remQuantity;
    data['received_quantity'] = receivedQuantity;
    data['is_finish'] = isFinish;
    data['is_cancelled'] = isCancelled;
    data['cancel_reason'] = cancelReason;
    data['notes'] = notes;
    data['is_close'] = isClose;
    data['branch_id'] = branchId;
    data['currency_id'] = currencyId;
    data['currency_val'] = currencyVal;
    data['unit_price'] = unitPrice;
    data['total_price'] = totalPrice;
    data['xdisc'] = xdisc;
    data['net_amount'] = netAmount;
    data['is_paid'] = isPaid;
    data['size_id'] = sizeId;
    data['color_id'] = colorId;
    data['xitem_id'] = xitemId;
    data['state_id'] = stateId;
    data['out_id'] = outId;
    data['is_sales_part'] = isSalesPart;
    data['date_expire'] = dateExpire;
    data['zdate'] = zdate;
    data['vat_value'] = vatValue;
    data['vat_sale_per'] = vatSalePer;
    return data;
  }
}