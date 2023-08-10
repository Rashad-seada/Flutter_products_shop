class LoginEntity {
  String? res;
  String? msg;
  String? id;

  LoginEntity({this.res, this.msg, this.id});

  LoginEntity.fromJson(Map<String, dynamic> json) {
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