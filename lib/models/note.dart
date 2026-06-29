import 'package:isar/isar.dart';

part 'note.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;
  late String title;
  late String description;
  late String subject;
  late String priority;
  bool isFav = false;
}
