import 'package:moor/moor.dart';

class ItemDistributionTable extends Table {
  @override
  String get tableName => 'item_distributions';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get item =>
      integer().customConstraint('NOT NULL REFERENCES items(id)')();

  IntColumn get distributor =>
      integer().customConstraint('NOT NULL REFERENCES distributors(id)')();

  RealColumn get price => real()();
}
