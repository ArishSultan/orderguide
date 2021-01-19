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
}
