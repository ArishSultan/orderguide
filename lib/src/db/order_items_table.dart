import 'package:moor/moor.dart';

class OrderItemsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quantity => integer()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  IntColumn get orderId => integer().customConstraint('NOT NULL REFERENCES orders(id)')();
}
