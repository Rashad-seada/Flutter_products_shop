class UpdateProfileEntity {
  int? statusCode;
  String? res;
  String? msg;
  String? id;
  String? utype;

  UpdateProfileEntity({this.statusCode,this.res, this.msg, this.id, this.utype});

  UpdateProfileEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
    res = json['res'];
    msg = json['msg'];
    id = json['id'];
    utype = json['utype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['res'] = res;
    data['msg'] = msg;
    data['id'] = id;
    data['utype'] = utype;
    return data;
  }
}