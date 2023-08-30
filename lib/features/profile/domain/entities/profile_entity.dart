class ProfileEntity {
  int? statusCode;
  int? id;
  int? fdate;
  int? hfdate;
  int? ftime;
  Null? fupdate;
  Null? hfupdate;
  Null? utime;
  Null? fdelete;
  Null? hfdelete;
  Null? dtime;
  int? userid;
  Null? updateUserid;
  Null? deleteUserid;
  int? flagnet;
  String? etxt;
  String? atxt;
  String? uname;
  String? upass;
  String? umail;
  int? utype;
  int? active;
  String? lastvisit;
  String? uimg;
  String? lang;
  int? login;
  int? branchId;
  String? street;
  Null? address;
  String? mobile;
  String? mobile2;
  String? telephone;
  String? email2;
  int? ulevel;
  int? prevLevel;
  String? ulevelDate;
  int? emailsSent;
  int? emailsRec;
  int? smsSentCount;
  int? visits;
  String? notes;
  int? countryId;
  int? regionId;
  String? cityId;
  String? inregion;
  int? points;
  int? parentUserid;
  String? identityImg;
  String? birthDate;
  int? nationality;
  int? checkout;
  int? pkgId;
  int? tmpId;
  String? gender;
  int? isRepresintive;
  int? isMarketer;
  String? updateCode;
  Null? bebuserid;
  String? fname;
  String? lname;
  int? groupId;
  String? deviceId;
  String? lastIp;
  int? contractId;
  int? jobId;
  int? empId;
  int? approvId;
  int? isCancelled;
  int? screenSaverSec;
  String? xaddress;
  int? outId;
  String? maploc;

  ProfileEntity(
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
        this.etxt,
        this.atxt,
        this.uname,
        this.upass,
        this.umail,
        this.utype,
        this.active,
        this.lastvisit,
        this.uimg,
        this.lang,
        this.login,
        this.branchId,
        this.street,
        this.address,
        this.mobile,
        this.mobile2,
        this.telephone,
        this.email2,
        this.ulevel,
        this.prevLevel,
        this.ulevelDate,
        this.emailsSent,
        this.emailsRec,
        this.smsSentCount,
        this.visits,
        this.notes,
        this.countryId,
        this.regionId,
        this.cityId,
        this.inregion,
        this.points,
        this.parentUserid,
        this.identityImg,
        this.birthDate,
        this.nationality,
        this.checkout,
        this.pkgId,
        this.tmpId,
        this.gender,
        this.isRepresintive,
        this.isMarketer,
        this.updateCode,
        this.bebuserid,
        this.fname,
        this.lname,
        this.groupId,
        this.deviceId,
        this.lastIp,
        this.contractId,
        this.jobId,
        this.empId,
        this.approvId,
        this.isCancelled,
        this.screenSaverSec,
        this.xaddress,
        this.outId,
        this.maploc});

  ProfileEntity.fromJson(Map<String, dynamic> json,this.statusCode,) {
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
    etxt = json['etxt'];
    atxt = json['atxt'];
    uname = json['uname'];
    upass = json['upass'];
    umail = json['umail'];
    utype = json['utype'];
    active = json['active'];
    lastvisit = json['lastvisit'];
    uimg = json['uimg'];
    lang = json['lang'];
    login = json['login'];
    branchId = json['branch_id'];
    street = json['street'];
    address = json['address'];
    mobile = json['mobile'];
    mobile2 = json['mobile2'];
    telephone = json['telephone'];
    email2 = json['email2'];
    ulevel = json['ulevel'];
    prevLevel = json['prev_level'];
    ulevelDate = json['ulevel_date'];
    emailsSent = json['emails_sent'];
    emailsRec = json['emails_rec'];
    smsSentCount = json['sms_sent_count'];
    visits = json['visits'];
    notes = json['notes'];
    countryId = json['country_id'];
    regionId = json['region_id'];
    cityId = json['city_id'];
    inregion = json['inregion'];
    points = json['points'];
    parentUserid = json['parent_userid'];
    identityImg = json['identity_img'];
    birthDate = json['birth_date'];
    nationality = json['nationality'];
    checkout = json['checkout'];
    pkgId = json['pkg_id'];
    tmpId = json['tmp_id'];
    gender = json['gender'];
    isRepresintive = json['is_represintive'];
    isMarketer = json['is_marketer'];
    updateCode = json['update_code'];
    bebuserid = json['bebuserid'];
    fname = json['fname'];
    lname = json['lname'];
    groupId = json['group_id'];
    deviceId = json['device_id'];
    lastIp = json['last_ip'];
    contractId = json['contract_id'];
    jobId = json['job_id'];
    empId = json['emp_id'];
    approvId = json['approv_id'];
    isCancelled = json['is_cancelled'];
    screenSaverSec = json['screen_saver_sec'];
    xaddress = json['xaddress'];
    outId = json['out_id'];
    maploc = json['maploc'];
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
    data['etxt'] = etxt;
    data['atxt'] = atxt;
    data['uname'] = uname;
    data['upass'] = upass;
    data['umail'] = umail;
    data['utype'] = utype;
    data['active'] = active;
    data['lastvisit'] = lastvisit;
    data['uimg'] = uimg;
    data['lang'] = lang;
    data['login'] = login;
    data['branch_id'] = branchId;
    data['street'] = street;
    data['address'] = address;
    data['mobile'] = mobile;
    data['mobile2'] = mobile2;
    data['telephone'] = telephone;
    data['email2'] = email2;
    data['ulevel'] = ulevel;
    data['prev_level'] = prevLevel;
    data['ulevel_date'] = ulevelDate;
    data['emails_sent'] = emailsSent;
    data['emails_rec'] = emailsRec;
    data['sms_sent_count'] = smsSentCount;
    data['visits'] = visits;
    data['notes'] = notes;
    data['country_id'] = countryId;
    data['region_id'] = regionId;
    data['city_id'] = cityId;
    data['inregion'] = inregion;
    data['points'] = points;
    data['parent_userid'] = parentUserid;
    data['identity_img'] = identityImg;
    data['birth_date'] = birthDate;
    data['nationality'] = nationality;
    data['checkout'] = checkout;
    data['pkg_id'] = pkgId;
    data['tmp_id'] = tmpId;
    data['gender'] = gender;
    data['is_represintive'] = isRepresintive;
    data['is_marketer'] = isMarketer;
    data['update_code'] = updateCode;
    data['bebuserid'] = bebuserid;
    data['fname'] = fname;
    data['lname'] = lname;
    data['group_id'] = groupId;
    data['device_id'] = deviceId;
    data['last_ip'] = lastIp;
    data['contract_id'] = contractId;
    data['job_id'] = jobId;
    data['emp_id'] = empId;
    data['approv_id'] = approvId;
    data['is_cancelled'] = isCancelled;
    data['screen_saver_sec'] = screenSaverSec;
    data['xaddress'] = xaddress;
    data['out_id'] = outId;
    data['maploc'] = maploc;
    return data;
  }
}