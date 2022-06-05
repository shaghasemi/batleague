import 'package:hive_flutter/hive_flutter.dart';
import 'rating.model.dart';

part 'personnel.model.g.dart';

@HiveType(typeId: 10)
class PersonnelModel extends HiveObject {
  @HiveField(100)
  String? name;
  @HiveField(101)
  String? surname;
  @HiveField(102)
  String email;
  @HiveField(103)
  String? cellphone;
  @HiveField(104)
  List<Rating?>? ratings;
  @HiveField(105)
  String? rank;
  @HiveField(106)
  String? position;
  @HiveField(107)
  String? token;
  @HiveField(108)
  String password;

  PersonnelModel({
    this.name,
    this.surname,
    required this.email,
    this.cellphone,
    this.ratings,
    this.rank,
    this.position,
    this.token,
    required this.password,
  });
}
