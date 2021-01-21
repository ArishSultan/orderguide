import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/models/item_distribution.dart';
import 'package:orderguide/src/models/order_item.dart';

class Order {
  int id;
  double price;
  DateTime createdAt;
  Distributor distributor;

  List<OrderItem> items;

  Order({
    this.id,
    this.price,
    this.createdAt,
    this.distributor,
    this.items,
  });
}
