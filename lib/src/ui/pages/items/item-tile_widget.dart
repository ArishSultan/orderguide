import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/models/item.dart';
import 'package:orderguide/src/ui/pages/items/add-items_page.dart';
import 'package:orderguide/src/ui/pages/items/item-distributions-list_page.dart';
import 'package:orderguide/src/ui/widgets/confirmation.dart';
import 'package:orderguide/src/ui/widgets/fancy_tile.dart';
import 'package:orderguide/src/ui/widgets/dismissible_tile.dart';
import 'package:orderguide/src/utils/lazy_task.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final VoidCallback onChanged;

  ItemTile(this.item, this.onChanged);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: DismissibleTile(
        onEdit: () async {
          await AppNavigation.to(context, AddItems(item));
          onChanged?.call();
          return false;
        },
        onRemove: () => showConfirmation(
          context,
          onCanceled: () => false,
          onConfirmed: () async {
            final resp = await performLazyTask(context, () async {
              final data = await AppDB().getItemDistributions(item);

              if (data.isNotEmpty) {
                return false;
              } else {
                await AppDB().deleteItem(item);
                onChanged?.call();
                return true;
              }
            });

            if (!resp) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Many Distributions are linked to this '
                      'item, delete them first'),
                )
              );
            }

            return resp;
          },
        ),
        child: FancyTile(
          onTap: () => AppNavigation.to(context, ItemDistributionsListPage(item: item)),
          leading: CircleAvatar(
            radius: 23,
            child: Text(item.name[0], style: TextStyle(color: Colors.white)),
          ),
          title: Text(item.name, style: TextStyle(color: color)),
        ),
      ),
    );
  }
}
