import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/ui/pages/distributors/edit-distributor_page.dart';
import 'package:orderguide/src/ui/widgets/dismissible_tile.dart';
import 'package:orderguide/src/ui/widgets/fancy_tile.dart';
import 'package:orderguide/src/utils/lazy_task.dart';

import 'confirmation.dart';

class DistributorTile extends StatelessWidget {
  final bool dismissible;
  final VoidCallback onTap;
  final VoidCallback onUpdated;
  final Distributor distributor;

  DistributorTile(
    this.distributor, {
    this.dismissible = false,
    this.onTap,
    this.onUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    final tile = FancyTile(
      onTap: onTap,
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
            await AppNavigation.to(context, EditDistributor(distributor));
            onUpdated?.call();
            return false;
          },
          onRemove: () => showConfirmation(
            context,
            onCanceled: () => false,
            onConfirmed: () async {
              final resp = await performLazyTask(context, () async {
                final data = await AppDB().getDistributorDistributions(distributor);
                if (data.isNotEmpty) {
                  return false;
                } else {
                  await AppDB().deleteDistributor(distributor);
                  await AppDB().deleteDistributorOrders(distributor);
                  return true;
                }
              });

              if (!resp) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Many items contain cost for this '
                          'Distributor, delete them first.Any order linked to this distributor will be removed too'),
                    )
                );
              }
              return resp;
            },
          )
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
