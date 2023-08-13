class ValidateCodeEntity {
  String? res;
  String? msg;
  int statusCode;

  ValidateCodeEntity({this.res, this.msg,required this.statusCode});

  ValidateCodeEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
    res = json['res'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res'] = this.res;
    data['msg'] = this.msg;
    return data;
  }
}