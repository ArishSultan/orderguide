import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/models/order_item.dart';

class Order {
  int id;
  int count;
  double price;
  bool completed;
  DateTime createdAt;
  Distributor distributor;

  List<OrderItem> items;

  Order({
    this.id,
    this.price,
    this.completed,
    this.createdAt,
    this.distributor,
    this.items,
  });
}
