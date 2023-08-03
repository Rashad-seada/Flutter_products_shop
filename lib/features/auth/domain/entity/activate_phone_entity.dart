class ActivatePhoneEntity {
  String? res;
  String? msg;

  ActivatePhoneEntity({this.res, this.msg});

  ActivatePhoneEntity.fromJson(Map<String, dynamic> json) {
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