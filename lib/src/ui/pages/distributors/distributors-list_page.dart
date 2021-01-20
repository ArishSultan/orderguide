import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/ui/views/item_search_view.dart';
import 'package:orderguide/src/ui/pages/items/items-list_page.dart';
import 'package:orderguide/src/ui/pages/distributors/add-distributors_page.dart';
import 'package:orderguide/src/ui/pages/distributors/distributor-tile_widget.dart';
import 'package:orderguide/src/ui/widgets/fancy_tile.dart';

class DistributorsListPage extends StatelessWidget {
  final controller = ItemSearchViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Distributors'),
      ),
      body: ItemSearchView<Distributor>(
        controller: controller,
        onFetch: AppDB().getDistributors,
        builder: (context, item, _) {
          return FancyTile();
          // return DistributorTile(
          //   item: item,
          //   onTap: () =>
          //       AppNavigation.to(context, ItemsList(distributor: item)),
          // );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.add),
        onPressed: () async {
          await AppNavigation.to(context, AddDistributors());
          controller.refresh();
        },
      ),
    );
  }
}
