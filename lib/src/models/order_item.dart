import 'package:orderguide/src/models/item.dart';

class OrderItem extends Item {
  int itemId;
  int orderId;
  int quantity;
  double price;
  bool completed;

  OrderItem({
    int id,
    String name,
    this.itemId,
    this.orderId,
    this.quantity,
    this.price,
    this.completed,
  }) : super(
          id: id,
          name: name,
        );
}
