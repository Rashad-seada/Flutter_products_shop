class AddFavoriteEntity {
  int? statusCode;
  String? res;
  String? msg;

  AddFavoriteEntity({this.res, this.msg});

  AddFavoriteEntity.fromJson(Map<String, dynamic> json,this.statusCode) {
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