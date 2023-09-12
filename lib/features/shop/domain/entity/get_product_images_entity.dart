class GetProductImagesEntity {
  String? res;
  String? msg;
  String? imgsLinks;
  String? thLinks;

  GetProductImagesEntity({this.res, this.msg, this.imgsLinks, this.thLinks});

  GetProductImagesEntity.fromJson(Map<String, dynamic> json) {
    res = json['res'];
    msg = json['msg'];
    imgsLinks = json['imgs_links'];
    thLinks = json['th_links'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['res'] = res;
    data['msg'] = msg;
    data['imgs_links'] = imgsLinks;
    data['th_links'] = thLinks;
    return data;
  }
}