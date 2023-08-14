class ResetPasswordByEmailEntity {
  String? res;
  String? msg;
  int? statusCode;
  ResetPasswordByEmailEntity({this.res, this.msg,this.statusCode});

  ResetPasswordByEmailEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
    res = json['res'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['res'] = res;
    data['msg'] = msg;
    return data;
  }
}