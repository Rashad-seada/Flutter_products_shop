class ValidatePhoneEntity {
  String? res;
  String? msg;

  ValidatePhoneEntity({this.res, this.msg});

  ValidatePhoneEntity.fromJson(Map<String, dynamic> json) {
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