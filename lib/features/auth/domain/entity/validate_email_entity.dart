class ValidateEmailEntity {
  String? res;
  String? msg;
  int statusCode;

  ValidateEmailEntity({this.res, this.msg,required this.statusCode});

  ValidateEmailEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
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
