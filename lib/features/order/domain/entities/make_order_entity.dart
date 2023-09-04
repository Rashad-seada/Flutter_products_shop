class MakeOrderEntity {
  int? statusCode;
  String? res;
  String? msg;

  MakeOrderEntity({this.res, this.msg,this.statusCode});

  MakeOrderEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
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