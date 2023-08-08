import 'package:flutter/cupertino.dart';

class Service {
  String serviceName;
  String image;
  Widget? nextScreen;

  Service({required this.serviceName,required this.image,this.nextScreen});
}