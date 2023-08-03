class ValidateMobileEntity {
  String? res;
  String? msg;

  ValidateMobileEntity({this.res, this.msg});

  ValidateMobileEntity.fromJson(Map<String, dynamic> json) {
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
