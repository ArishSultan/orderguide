import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/models/order.dart';
import 'package:orderguide/src/ui/views/item_search_view.dart';

import 'order-detail_page.dart';

class HistoryListing extends StatefulWidget {
  final bool completed;

  HistoryListing(this.completed);

  @override
  _HistoryListingState createState() => _HistoryListingState();
}

class _HistoryListingState extends State<HistoryListing> {
  final controller = ItemSearchViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders History"),
      ),
      body: ItemSearchView<Order>(
        allowSearch: false,
        onFetch: ([str]) => AppDB().getAllOrders(completed: widget.completed),
        controller: controller,
        builder: (context, order, _) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: InkWell(
              onTap: () async {
                await AppNavigation.to(
                  context,
                  OrderDetailPage(order, !widget.completed),
                );

                controller.refresh();
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 1,
                          color: Colors.grey.shade200,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(order.distributor.name ?? 'asd'),
                              Text(
                                DateFormat('dd, MMM y').format(order.createdAt),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${order.count} ${order.count == 1 ? 'Item' : 'Items'}'),
                              Text("\$${order.price.toStringAsFixed(2)}"),
                            ],
                          ),
                          trailing: Icon(
                            CupertinoIcons.chevron_right,
                            color: Color.fromRGBO(75, 68, 206, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
