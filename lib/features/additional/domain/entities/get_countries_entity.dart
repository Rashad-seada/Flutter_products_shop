class GetCountriesEntity {
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
  int? xcid;
  String? countryCode;
  String? mobIntCode;
  String? telIntCode;
  int? itemsCounter;
  int? isArabic;
  int? publish;

  GetCountriesEntity(
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
        this.xcid,
        this.countryCode,
        this.mobIntCode,
        this.telIntCode,
        this.itemsCounter,
        this.isArabic,
        this.publish});

  GetCountriesEntity.fromJson(Map<String, dynamic> json) {
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
    xcid = json['xcid'];
    countryCode = json['country_code'];
    mobIntCode = json['mob_int_code'];
    telIntCode = json['tel_int_code'];
    itemsCounter = json['items_counter'];
    isArabic = json['is_arabic'];
    publish = json['publish'];
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
    data['atxt'] = this.atxt;
    data['etxt'] = this.etxt;
    data['xcid'] = this.xcid;
    data['country_code'] = this.countryCode;
    data['mob_int_code'] = this.mobIntCode;
    data['tel_int_code'] = this.telIntCode;
    data['items_counter'] = this.itemsCounter;
    data['is_arabic'] = this.isArabic;
    data['publish'] = this.publish;
    return data;
  }
}