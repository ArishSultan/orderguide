import 'package:moor/moor.dart';

class DistributorTable extends Table {
  @override
  String get tableName => 'distributors';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().withLength(min: 11, max: 15)();
  TextColumn get email => text()();
  TextColumn get salesmanName => text()();
}
