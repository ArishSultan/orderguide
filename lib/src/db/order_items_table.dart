import 'package:moor/moor.dart';

class OrderItemsTable extends Table {
  IntColumn get itemId => integer()();
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quantity => integer()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  BoolColumn get completed => boolean()();
  IntColumn get orderId => integer().customConstraint('NOT NULL REFERENCES orders(id)')();
}
