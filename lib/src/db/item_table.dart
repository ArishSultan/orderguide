import 'package:moor/moor.dart';

class ItemTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}