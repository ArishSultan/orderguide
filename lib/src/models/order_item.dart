import 'package:orderguide/src/models/item.dart';

class OrderItem extends Item {
  int quantity;
  double price;

  OrderItem({
    int id,
    String name,
    this.quantity,
    this.price,
  }) : super(
          id: id,
          name: name,
        );
}
