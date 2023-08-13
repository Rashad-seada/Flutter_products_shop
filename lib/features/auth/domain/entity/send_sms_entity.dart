class SendSmsEntity {
  String? res;
  String? msg;
  int statusCode;

  SendSmsEntity({this.res, this.msg,required this.statusCode});

  SendSmsEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
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