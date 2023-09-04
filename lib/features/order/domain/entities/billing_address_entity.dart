import 'package:floor/floor.dart';

@Entity(tableName: "BillingAddressEntity")
class BillingAddressEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String area;
  String city;
  String neighborhood;
  String address;
  String note;
  String mobile;

  BillingAddressEntity(
      {this.id,
      required this.area,
      required this.city,
      required this.neighborhood,
      required this.address,
      required this.note,
      required this.mobile});
}
