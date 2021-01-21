import 'package:orderguide/src/models/item.dart';

class OrderItem extends Item {
  int quantity;
  double price;
  bool completed;
  int orderId;

  OrderItem({
    int id,
    String name,
    this.orderId,
    this.quantity,
    this.price,
    this.completed,
  }) : super(
          id: id,
          name: name,
        );
}
