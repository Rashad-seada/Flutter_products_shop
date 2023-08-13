class LoginEntity {
  String? res;
  String? msg;
  String? id;
  int statusCode;

  LoginEntity({this.res, this.msg, this.id,required this.statusCode});

  LoginEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
    res = json['res'];
    msg = json['msg'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res'] = this.res;
    data['msg'] = this.msg;
    data['id'] = this.id;
    return data;
  }
}