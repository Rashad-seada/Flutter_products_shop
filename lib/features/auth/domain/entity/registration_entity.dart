class RegistrationEntity {
  String? res;
  String? msg;
  int statusCode;

  RegistrationEntity({this.res, this.msg,required this.statusCode});

  RegistrationEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
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