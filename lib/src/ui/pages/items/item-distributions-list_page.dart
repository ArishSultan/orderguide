import 'package:flutter/material.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/models/item.dart';
import 'package:orderguide/src/ui/widgets/confirmation.dart';
import 'package:orderguide/src/ui/widgets/dismissible_tile.dart';
import 'package:orderguide/src/ui/widgets/fancy_tile.dart';
import 'package:orderguide/src/models/item_distribution.dart';
import 'package:orderguide/src/ui/views/item_search_view.dart';
import 'package:orderguide/src/ui/widgets/item-price_dialog.dart';
import 'package:orderguide/src/ui/widgets/simple_future.dart';
import 'package:orderguide/src/utils/lazy_task.dart';

class ItemDistributionsListPage extends StatefulWidget {
  final Item item;
  final Distributor distributor;

  ItemDistributionsListPage({this.item, this.distributor})
      : assert(
          item != null || distributor != null,
          'Either of these must not be null',
        );

  @override
  _ItemDistributionsListPageState createState() =>
      _ItemDistributionsListPageState();
}

class _ItemDistributionsListPageState extends State<ItemDistributionsListPage> {
  var loading = false;
  final controller = ItemSearchViewController();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item != null ? widget.item.name : widget.distributor.name,
        ),
      ),
      body: loading
          ? CircularProgressIndicator()
          : ItemSearchView<ItemDistribution>(
              allowSearch: false,
              controller: controller,
              emptyMessage: widget.item !=null ? 'No distributors added for this Item' : 'No items added for this Distributor',
              onFetch: ([str]) {
                if (widget.item != null) {
                  return AppDB().getItemDistributions(widget.item);
                } else {
                  return AppDB()
                      .getDistributorDistributions(widget.distributor);
                }
              },
              builder: (context, item, _) {
                return SimpleFutureBuilder<void>(
                  future:
                      Future.wait([item.item.fill(), item.distributor.fill()]),
                  builder: (context, a) => Padding(
                    padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                    child: DismissibleTile(
                      onEdit: () async {
                        final price = await showDialog(
                          context: context,
                          builder: (context) => ItemPriceDialog(
                            price: item.price,
                          ),
                        );

                        if (price != null) {
                          item.price = price;
                          await performLazyTask(context, () async {
                            AppDB().updateDistribution(item);
                          });

                          setState(() {});
                        }

                        return false;
                      },
                      onRemove: () async {
                        return showConfirmation(
                          context,
                          onCanceled: () async => false,
                          onConfirmed: () async {
                            final i =
                                await AppDB().deleteItemDistribution(item);
                            print(i);
                            return true;
                          },
                        );
                      },
                      child: FancyTile(
                        title: Text(
                          item.item?.name ?? 'asd',
                          style: TextStyle(
                            color: color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(item.distributor?.name ?? 'asd'),
                        trailing: Text(
                          '\$${item.price}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
