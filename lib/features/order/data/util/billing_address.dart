import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Person extends HiveObject {

  @HiveField(0)
  int countryId;

  @HiveField(1)
  int areaId;

  @HiveField(2)
  int cityId;

  @HiveField(3)
  String address;

  @HiveField(4)
  String phone;

  Person({required this.countryId,required this.areaId,required this.cityId,required this.address,required this.phone});
}