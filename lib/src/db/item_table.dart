import 'package:moor/moor.dart';

class ItemTable extends Table {
  @override
  String get tableName => 'items';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}