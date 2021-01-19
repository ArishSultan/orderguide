import 'dart:io';

import 'package:orderguide/src/db/item_table.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:orderguide/src/db/distributor_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

@UseMoor(tables: [DistributorTable, ItemTable])
class AppDB extends _$AppDB {
  static AppDB _instance;

  AppDB._() : super(_openConnection());

  factory AppDB() {
    // _instance?.close();
    // _instance = AppDB._();
    // return _instance;
    if (_instance == null) {
      _instance = AppDB._();
    }

    return _instance;
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'db.sqlite'));
      return VmDatabase(file);
    });
  }

  @override
  int get schemaVersion => 1;

  Future<int> addDistributor(Distributor entry) {
    return into(distributorTable).insert(_createDistributorCompanion(entry));
  }

  Future<List<Distributor>> getDistributors(String name) async {
    List<DistributorTableData> distributors;
    if (name?.isNotEmpty != null) {
      final query = select(distributorTable)
        ..where((tbl) => tbl.name.like('%$name%'));
      distributors = await query.get();
    } else {
      distributors = await select(distributorTable).get();
    }
    return distributors
        .map(
          (e) => Distributor(
            id: e.id,
            name: e.name,
            email: e.email,
            phone: e.phone,
            salesmanName: e.salesmanName,
          ),
        )
        .toList();
  }
}

DistributorTableCompanion _createItemCompanion(Distributor distributor) {
  return DistributorTableCompanion(
    id: distributor.id != null ? Value(distributor.id) : Value.absent(),
    name: Value(distributor.name),
    email: Value(distributor.email),
    phone: Value(distributor.phone),
    salesmanName: Value(distributor.salesmanName),
  );
}

DistributorTableCompanion _createItemDistributionCompanion(
    Distributor distributor) {
  return DistributorTableCompanion(
    id: distributor.id != null ? Value(distributor.id) : Value.absent(),
    name: Value(distributor.name),
    email: Value(distributor.email),
    phone: Value(distributor.phone),
    salesmanName: Value(distributor.salesmanName),
  );
}

DistributorTableCompanion _createDistributorCompanion(Distributor distributor) {
  return DistributorTableCompanion(
    id: distributor.id != null ? Value(distributor.id) : Value.absent(),
    name: Value(distributor.name),
    email: Value(distributor.email),
    phone: Value(distributor.phone),
    salesmanName: Value(distributor.salesmanName),
  );
}
