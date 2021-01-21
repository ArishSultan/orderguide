import 'package:flutter/material.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/ui/pages/items/item-history_page.dart';
import 'package:orderguide/src/ui/pages/items/item-tile_widget.dart';
import 'package:orderguide/src/ui/views/item_search_view.dart';
import 'package:orderguide/src/ui/widgets/dismissible_tile.dart';
import 'package:orderguide/src/ui/widgets/fancy_tile.dart';

class ItemSelectionPage extends StatelessWidget {
  final controller = ItemSearchViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ItemSearchView(
        controller: controller,
        onFetch: AppDB().getItems,
        builder: (context, item, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: FancyTile(
              onTap: () => AppNavigation.to(context, ItemHistoryPage(item)),
              leading: CircleAvatar(
                radius: 23,
                child: Text(item.name[0], style: TextStyle(color: Colors.white)),
              ),
              title: Text(item.name,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  )),
            ),
          );
        },
      ),
    );
  }
}
