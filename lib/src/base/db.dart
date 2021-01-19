import 'dart:io';

import 'package:orderguide/src/models/distributors-model.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:orderguide/src/db/distributor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

@UseMoor(tables: [DistributorTable])
class AppDB extends _$AppDB {
  static AppDB _instance;
  AppDB._() : super(_openConnection());
  factory AppDB() {
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

  Future<List<Distributor>> getDistributors() async {
    final distributors = await select(distributorTable).get();
    print('asdasd');
    print(distributors);
    return distributors.map(
      (e) => Distributor(
        id: e.id,
        name: e.name,
        email: e.email,
        phone: e.phone,
        salesmanName: e.salesmanName,
      ),
    ).toList();
  }
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