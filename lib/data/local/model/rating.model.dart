import 'package:hive_flutter/hive_flutter.dart';

part 'rating.model.g.dart';

@HiveType(typeId: 11)
class Rating extends HiveObject {
  @HiveField(110)
  String email;
  @HiveField(111)
  String title;

  Rating(this.email, this.title);
}
