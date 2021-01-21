import 'package:orderguide/src/models/item.dart';

class OrderItem extends Item {
  int quantity;
  double price;
  bool completed;

  OrderItem({
    int id,
    String name,
    this.quantity,
    this.price,
    this.completed,
  }) : super(
          id: id,
          name: name,
        );
}
