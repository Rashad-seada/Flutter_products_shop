class ResetPasswordBySMSEntity {
  String? res;
  String? msg;
  int statusCode;

  ResetPasswordBySMSEntity({this.res, this.msg,required this.statusCode});

  ResetPasswordBySMSEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
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