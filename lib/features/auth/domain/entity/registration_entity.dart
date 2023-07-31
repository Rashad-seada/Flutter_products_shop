class RegistrationEntity {
  String? res;
  String? msg;

  RegistrationEntity({this.res, this.msg});

  RegistrationEntity.fromJson(Map<String, dynamic> json) {
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