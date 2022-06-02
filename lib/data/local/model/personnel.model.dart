import 'package:hive_flutter/hive_flutter.dart';

part 'personnel.model.g.dart';

@HiveType(typeId: 10)
class Personnelodel extends HiveObject {
  @HiveField(100)
  String name;
  @HiveField(101)
  String surname;
  @HiveField(102)
  String email;
  @HiveField(103)
  String cellphone;
  @HiveField(104)
  List<String> ratings;
  @HiveField(105)
  String rank;
  @HiveField(106)
  String position;
  @HiveField(107)
  String token;

  @HiveField(103)
  Personnelodel(
    this.name,
    this.surname,
    this.ratings,
    this.token,
  );
}
