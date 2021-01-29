import 'package:moor/moor.dart';

class UserTable extends Table {
  @override
  String get tableName => 'users';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get email => text()();
  TextColumn get password => text()();
}