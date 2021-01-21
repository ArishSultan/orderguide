import 'dart:io';

import 'package:orderguide/src/db/item_table.dart';
import 'package:orderguide/src/db/items-distribution_table.dart';
import 'package:orderguide/src/db/order_items_table.dart';
import 'package:orderguide/src/db/orders_table.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:orderguide/src/db/distributor_table.dart';
import 'package:orderguide/src/models/item.dart';
import 'package:orderguide/src/models/item_distribution.dart';
import 'package:orderguide/src/models/item_purchase.dart';
import 'package:orderguide/src/models/order.dart';
import 'package:orderguide/src/models/order_item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

@UseMoor(tables: [
  DistributorTable,
  ItemTable,
  ItemDistributionTable,
  OrdersTable,
  OrderItemsTable
])
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
    // '''
    // into(distributorTable).insert()
    // INSERT INTO table_name(id, name) VALUES(0, 'Arish');
    // '''
    return into(distributorTable).insert(_createDistributorCompanion(entry));
  }

  Future<ItemTableData> getItem(int id) {
    return (select(itemTable)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<DistributorTableData> getDistributor(int id) {
    return (select(distributorTable)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<int> updateDistributor(Distributor entry) {
    return (update(distributorTable)..where((t) => t.id.equals(entry.id)))
        .write(_createDistributorCompanion(entry));
  }

  Future<int> deleteDistributor(Distributor entry) {
    return (delete(distributorTable)..where((t) => t.id.equals(entry.id))).go();
  }

  Future<int> addDistribution(ItemDistribution entry) {
    return into(itemDistributionTable)
        .insert(_createItemDistributionCompanion(entry));
  }

  Future<int> updateDistribution(ItemDistribution entry) {
    return (update(itemDistributionTable)..where((t) => t.id.equals(entry.id)))
        .write(_createItemDistributionCompanion(entry));
  }

  Future<int> deleteDistribution(ItemDistribution entry) {
    return (delete(itemDistributionTable)..where((t) => t.id.equals(entry.id)))
        .go();
  }

  Future<int> addItem(Item entry) {
    return into(itemTable).insert(_createItemCompanion(entry));
  }

  Future<int> deleteItem(Item entry) {
    return (delete(itemTable)..where((t) => t.id.equals(entry.id))).go();
  }

  Future<int> deleteItemDistribution(ItemDistribution distribution) {
    return (delete(itemDistributionTable)
          ..where((t) => t.id.equals(distribution.id)))
        .go();
  }

  Future<int> updateItem(Item entry) {
    return (update(itemTable)..where((t) => t.id.equals(entry.id)))
        .write(_createItemCompanion(entry));
  }

  Future<int> addItemDistribution(ItemDistribution entry) {
    return into(itemDistributionTable)
        .insert(_createItemDistributionCompanion(entry));
  }

  Future<List<ItemDistribution>> getDistributorDistributions(
      Distributor distributor) async {
    final data = await (select(itemDistributionTable)
          ..where((t) => t.distributor.equals(distributor.id)))
        .get();

    return data
        .map(
          (e) => ItemDistribution(
            id: e.id,
            price: e.price,
            item: Item(id: e.item),
            distributor: Distributor(id: e.distributor),
          ),
        )
        .toList();
  }

  Future<List<ItemDistribution>> getItemDistributions(Item item) async {
    final data = await (select(itemDistributionTable)
          ..where((t) => t.item.equals(item.id)))
        .get();

    return data
        .map(
          (e) => ItemDistribution(
            id: e.id,
            price: e.price,
            item: Item(id: e.item),
            distributor: Distributor(id: e.distributor),
          ),
        )
        .toList();
  }

  Future<List<OrderItem>> getOrderItems(int orderId) async {
    final items = await (select(orderItemsTable)
          ..where((tbl) => tbl.orderId.equals(orderId)))
        .get();

    return items
        .map(
          (e) => OrderItem(
            id: e.id,
            name: e.name,
            price: e.price,
            orderId: orderId,
            quantity: e.quantity,
            completed: e.completed,
          ),
        )
        .toList();
  }

  Future<List<ItemPurchase>> getItemPurchases(
    DateTime start,
    DateTime end,
    int itemId,
  ) async {
    final items = <ItemPurchase>[];
    final orders = await (select(ordersTable)
          ..where((tbl) =>
              tbl.createdAt.isBiggerOrEqualValue(start) &
              tbl.createdAt.isSmallerOrEqualValue(end) &
              tbl.completed.equals(true))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();

    for (final order in orders) {
      final orderItems = await (select(orderItemsTable)
            ..where((tbl) =>
                tbl.orderId.equals(order.id) &
                tbl.itemId.equals(itemId) &
                tbl.completed.equals(true)))
          .get();

      if (orderItems.isNotEmpty)
        items.add(ItemPurchase(
          price: orderItems.fold(0, (value, element) => value + element.price),
          time: order.createdAt,
          qty: orderItems.length,
        ));
    }

    return items;
  }

  Future<Order> getOrder(int id) async {
    final data =
        await (select(ordersTable)..where((t) => t.id.equals(id))).getSingle();

    final dist = Distributor(id: data.distributor);
    await dist.fill();

    return Order(
      id: data.id,
      price: data.price,
      createdAt: data.createdAt,
      distributor: dist,
      items: await getOrderItems(data.id),
    )..count = data.count;
  }

  Future<int> markOrderItemAsComplete(OrderItem item) {
    item.completed = true;
    return (update(orderItemsTable)..where((tbl) => tbl.id.equals(item.id)))
        .write(
      OrderItemsTableCompanion(
        id: Value(item.id),
        name: Value(item.name),
        price: Value(item.price),
        orderId: Value(item.orderId),
        quantity: Value(item.quantity),
        completed: Value(item.completed),
      ),
    );
  }

  Future<int> markOrderAsComplete(Order order) {
    order.completed = true;
    return (update(ordersTable)..where((tbl) => tbl.id.equals(order.id))).write(
      OrdersTableCompanion(
        id: Value(order.id),
        price: Value(order.price),
        count: Value(order.count),
        createdAt: Value(order.createdAt),
        completed: Value(order.completed),
        distributor: Value(order.distributor.id),
      ),
    );
  }

  Future<List<Order>> getAllOrders({bool completed = false}) async {
    final data = await (select(ordersTable)
          ..where((tbl) => tbl.completed.equals(completed))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                )
          ]))
        .get();
    final _data = <Order>[];

    for (final item in data) {
      final dist = Distributor(id: item.distributor);
      await dist.fill();

      _data.add(Order(
        id: item.id,
        price: item.price,
        createdAt: item.createdAt,
        distributor: dist,
      )..count = item.count);
    }

    return _data;
  }

  Future<int> updateItemDistribution(ItemDistribution entry) {
    return into(itemDistributionTable)
        .insert(_createItemDistributionCompanion(entry));
  }

  Future<int> placeOrder(Order order) async {
    final id = await into(ordersTable).insert(OrdersTableCompanion(
      id: Value.absent(),
      price: Value(order.price),
      count: Value(order.count),
      completed: Value(order.completed),
      createdAt: Value(order.createdAt),
      distributor: Value(order.distributor.id),
    ));

    for (final item in order.items) {
      await into(orderItemsTable).insert(OrderItemsTableCompanion(
        id: Value.absent(),
        itemId: Value(item.itemId),
        orderId: Value(id),
        name: Value(item.name),
        price: Value(item.price),
        quantity: Value(item.quantity),
        completed: Value(item.completed),
      ));
    }

    return 0;
  }

  Future<List<Distributor>> getDistributors([String name]) async {
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

  Future<List<Item>> getItems([String name]) async {
    List<ItemTableData> items;
    if (name?.isNotEmpty != null) {
      final query = select(itemTable)..where((tbl) => tbl.name.like('%$name%'));
      items = await query.get();
    } else {
      items = await select(itemTable).get();
    }

    return items.map((e) => Item(id: e.id, name: e.name)).toList();
  }
}

ItemTableCompanion _createItemCompanion(Item distributor) {
  return ItemTableCompanion(
    id: distributor.id != null ? Value(distributor.id) : Value.absent(),
    name: Value(distributor.name),
  );
}

ItemDistributionTableCompanion _createItemDistributionCompanion(
    ItemDistribution distribution) {
  return ItemDistributionTableCompanion(
    id: distribution.id != null ? Value(distribution.id) : Value.absent(),
    price: Value(distribution.price),
    item: Value(distribution.item.id),
    distributor: Value(distribution.distributor.id),
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
