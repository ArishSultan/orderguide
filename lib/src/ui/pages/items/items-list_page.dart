import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/models/item.dart';
import 'package:orderguide/src/ui/pages/items/add-items_page.dart';
import 'package:orderguide/src/ui/views/item_search_view.dart';
import 'item-tile_widget.dart';

class ItemsList extends StatefulWidget {
  final Distributor distributor;

  ItemsList({this.distributor});

  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  final controller = ItemSearchViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Items')),
      body: ItemSearchView<Item>(
        controller: controller,
        onFetch: AppDB().getItems,
        builder: (context, item, _) {
          return ItemTile(item, () => controller.refresh());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await AppNavigation.to(context, AddItems());
          controller.refresh();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
