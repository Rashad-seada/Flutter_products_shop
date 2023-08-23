class CategoryEntity {
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
  String? atxt;
  String? etxt;
  int? parentId;
  String? xpath;
  String? adetails;
  String? edetails;
  int? isAddStore;
  int? isActive;
  int? isPublish;
  String? notes;
  String? img;
  String? backTreeIds;
  String? backTreeLinks;
  String? arBackTreeLinks;
  String? frontTreeIds;
  int? outId;
  String? categoryPrntr;
  int? itemsCount;
  int? maxDiscPer;
  int? vatSalePer;

  CategoryEntity(
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
        this.atxt,
        this.etxt,
        this.parentId,
        this.xpath,
        this.adetails,
        this.edetails,
        this.isAddStore,
        this.isActive,
        this.isPublish,
        this.notes,
        this.img,
        this.backTreeIds,
        this.backTreeLinks,
        this.arBackTreeLinks,
        this.frontTreeIds,
        this.outId,
        this.categoryPrntr,
        this.itemsCount,
        this.maxDiscPer,
        this.vatSalePer});

  CategoryEntity.fromJson(Map<String, dynamic> json) {
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
    atxt = json['atxt'];
    etxt = json['etxt'];
    parentId = json['parent_id'];
    xpath = json['xpath'];
    adetails = json['adetails'];
    edetails = json['edetails'];
    isAddStore = json['is_add_store'];
    isActive = json['is_active'];
    isPublish = json['is_publish'];
    notes = json['notes'];
    img = json['img'];
    backTreeIds = json['back_tree_ids'];
    backTreeLinks = json['back_tree_links'];
    arBackTreeLinks = json['ar_back_tree_links'];
    frontTreeIds = json['front_tree_ids'];
    outId = json['out_id'];
    categoryPrntr = json['category_prntr'];
    itemsCount = json['items_count'];
    maxDiscPer = json['max_disc_per'];
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
    data['atxt'] = atxt;
    data['etxt'] = etxt;
    data['parent_id'] = parentId;
    data['xpath'] = xpath;
    data['adetails'] = adetails;
    data['edetails'] = edetails;
    data['is_add_store'] = isAddStore;
    data['is_active'] = isActive;
    data['is_publish'] = isPublish;
    data['notes'] = notes;
    data['img'] = img;
    data['back_tree_ids'] = backTreeIds;
    data['back_tree_links'] = backTreeLinks;
    data['ar_back_tree_links'] = arBackTreeLinks;
    data['front_tree_ids'] = frontTreeIds;
    data['out_id'] = outId;
    data['category_prntr'] = categoryPrntr;
    data['items_count'] = itemsCount;
    data['max_disc_per'] = maxDiscPer;
    data['vat_sale_per'] = vatSalePer;
    return data;
  }
}