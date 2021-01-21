import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/ui/views/item_search_view.dart';
import 'package:orderguide/src/ui/widgets/distributor_tile.dart';
import 'package:orderguide/src/ui/pages/generate_orders/generate-order_items.dart';

class GenerateOrderDistributorsList extends StatefulWidget {
  @override
  _GenerateOrderDistributorsListState createState() =>
      _GenerateOrderDistributorsListState();
}

class _GenerateOrderDistributorsListState
    extends State<GenerateOrderDistributorsList> {
  final controller = ItemSearchViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a Distributor"),
        centerTitle: true,
      ),
      body: ItemSearchView(
        controller: controller,
        onFetch: AppDB().getDistributors,
        builder: (context, item, _) {
          return DistributorTile(item, onTap: () {
            AppNavigation.to(context, GenerateOrderItems(item));
          });
        },
      ),
    );
  }
}
