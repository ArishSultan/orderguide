import 'package:moor/moor.dart';

class OrdersTable extends Table {
  @override
  String get tableName => 'orders';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get count => integer()();
  BoolColumn get completed => boolean()();

  IntColumn get distributor =>
      integer().customConstraint('NOT NULL REFERENCES distributors(id)')();

  RealColumn get price => real()();

  DateTimeColumn get createdAt => dateTime()();
}
