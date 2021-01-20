import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/ui/pages/distributors/add-distributors_page.dart';
import 'package:orderguide/src/ui/widgets/dismissible_tile.dart';
import 'package:orderguide/src/ui/widgets/fancy_tile.dart';
import 'package:orderguide/src/utils/lazy_task.dart';

class DistributorTile extends StatelessWidget {
  final bool dismissible;
  final VoidCallback onTap;
  final Distributor distributor;

  DistributorTile(this.distributor, {this.dismissible = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    final tile = FancyTile(
      title: Text(distributor.name, style: TextStyle(color: color)),
      leading: CircleAvatar(
        radius: 23,
        child: Text(distributor.name[0], style: TextStyle(color: Colors.white)),
      ),
    );

    if (dismissible) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: DismissibleTile(
          child: tile,
          onEdit: () async {
            AppNavigation.to(context, AddDistributors());
            return false;
          },
          onRemove: () async {
            final result = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Are you sure?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Yes')),
                    TextButton(onPressed: Navigator.of(context).pop, child: Text('No')),
                  ],
                );
              },
            );

            if (result != null) {
              await performLazyTask(context, () => AppDB().deleteDistributor(distributor));
              return true;
            } else {
              return false;
            }
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: tile,
      );
    }
  }
}
