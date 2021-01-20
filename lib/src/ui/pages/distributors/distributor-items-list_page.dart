import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/models/item_distribution.dart';
import 'package:orderguide/src/ui/views/item_search_view.dart';
import 'package:orderguide/src/ui/widgets/fancy_tile.dart';

class DistributorItemsListPage extends StatelessWidget {
  DistributorItemsListPage(this.distributor);

  final Distributor distributor;
  final controller = ItemSearchViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items of ${distributor.name}'),
      ),
      body: ItemSearchView<ItemDistribution>(
        allowSearch: false,
        controller: controller,
        onFetch: ([str]) => AppDB().getDistributorDistributions(distributor),
        builder: (context, item, _) {
          return FancyTile(
            title: Text('ASD'),
          );
        },
      ),
    );
  }
}
