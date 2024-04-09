import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class ItemDatabase extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  int time;

  @HiveField(2)
  String img;

  @HiveField(3)
  int id;
  ItemDatabase(
      {required this.img,
      required this.time,
      required this.title,
      required this.id});
}
