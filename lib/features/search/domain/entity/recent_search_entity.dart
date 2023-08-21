import 'package:floor/floor.dart';

@Entity(tableName: "RecentSearchEntity")
class RecentSearchEntity {

  @PrimaryKey(autoGenerate: true)
  int? id;

  String searchTerm;

  RecentSearchEntity({this.id,required this.searchTerm});
}

