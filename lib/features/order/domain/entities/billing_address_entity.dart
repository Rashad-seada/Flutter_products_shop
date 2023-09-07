import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class BillingAddressEntity extends HiveObject {

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

  BillingAddressEntity({required this.countryId,required this.areaId,required this.cityId,required this.address,required this.phone});
}


class BillingAddressEntityAdapter extends TypeAdapter<BillingAddressEntity> {
  @override
  final int typeId = 0; // Assign the same typeId as in the @HiveType annotation

  @override
  BillingAddressEntity read(BinaryReader reader) {
    return BillingAddressEntity(
      countryId: reader.readInt(),
      areaId: reader.readInt(),
      cityId: reader.readInt(),
      address: reader.readString(),
      phone: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, BillingAddressEntity obj) {
    writer.writeInt(obj.countryId);
    writer.writeInt(obj.areaId);
    writer.writeInt(obj.cityId);
    writer.writeString(obj.address);
    writer.writeString(obj.phone);
  }
}
