class GetCitiesEntity {
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
  int? countryId;
  int? regionId;
  String? etxt;
  String? atxt;
  int? marketsCounter;
  int? itemsCounter;
  int? publish;

  GetCitiesEntity(
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
        this.countryId,
        this.regionId,
        this.etxt,
        this.atxt,
        this.marketsCounter,
        this.itemsCounter,
        this.publish});

  GetCitiesEntity.fromJson(Map<String, dynamic> json) {
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
    countryId = json['country_id'];
    regionId = json['region_id'];
    etxt = json['etxt'];
    atxt = json['atxt'];
    marketsCounter = json['markets_counter'];
    itemsCounter = json['items_counter'];
    publish = json['publish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['country_id'] = countryId;
    data['region_id'] = regionId;
    data['etxt'] = etxt;
    data['atxt'] = atxt;
    data['markets_counter'] = marketsCounter;
    data['items_counter'] = itemsCounter;
    data['publish'] = publish;
    return data;
  }
}