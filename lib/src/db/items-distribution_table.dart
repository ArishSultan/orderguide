import 'package:moor/moor.dart';

class ItemDistributionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  // IntColumn get item => integer().customConstraint('NOT NULL REFERENCES items(id)')();
}