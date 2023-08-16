import '../util/user_type_enum.dart';

class LoginEntity {
  String? res;
  String? msg;
  String? id;
  UserType? utype;
  int? statusCode;

  LoginEntity({this.res, this.msg, this.id, this.utype,this.statusCode});

  LoginEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
    res = json['res'];
    msg = json['msg'];
    id = json['id'];
    utype = fromIntToUserType(json['utype']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res'] = this.res;
    data['msg'] = this.msg;
    data['id'] = this.id;
    data['utype'] = this.utype;
    return data;
  }
}