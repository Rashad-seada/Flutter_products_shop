class SendSmsEntity {
  String? res;
  String? msg;

  SendSmsEntity({this.res, this.msg});

  SendSmsEntity.fromJson(Map<String, dynamic> json) {
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