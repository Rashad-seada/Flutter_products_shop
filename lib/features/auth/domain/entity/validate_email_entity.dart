class ValidateEmailEntity {
  String? res;
  String? msg;

  ValidateEmailEntity({this.res, this.msg});

  ValidateEmailEntity.fromJson(Map<String, dynamic> json) {
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
