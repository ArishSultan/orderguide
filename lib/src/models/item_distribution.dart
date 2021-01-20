import 'package:orderguide/src/models/distributor.dart';

import 'item.dart';

class ItemDistribution {
  int id;
  Item item;
  double price;
  Distributor distributor;

  ItemDistribution({
    this.id,
    this.item,
    this.price,
    this.distributor,
  });

  @override
  String toString() {
    return 'ItemDistribution(item: ${item.id}, distributor: ${distributor.id})';
  }
}
