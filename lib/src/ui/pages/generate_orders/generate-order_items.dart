import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/models/item_distribution.dart';
import 'package:orderguide/src/models/order.dart';
import 'package:orderguide/src/models/order_item.dart';
import 'package:orderguide/src/ui/pages/items/add-items_page.dart';
import 'package:orderguide/src/ui/views/item_search_view.dart';
import 'package:orderguide/src/ui/widgets/confirmation.dart';
import 'package:orderguide/src/ui/widgets/counter.dart';
import 'package:orderguide/src/ui/widgets/fancy_tile.dart';
import 'package:orderguide/src/utils/const.dart';
import 'package:intl/intl.dart';
import 'package:orderguide/src/utils/lazy_task.dart';
import 'package:orderguide/src/utils/send-sms.dart';

class GenerateOrderItems extends StatefulWidget {
  final Distributor distributor;

  GenerateOrderItems(this.distributor);

  @override
  _GenerateOrderItemsState createState() => _GenerateOrderItemsState();
}

class _GenerateOrderItemsState extends State<GenerateOrderItems> {
  List<ItemDistribution> distributions;

  var isSent = false;
  var loading = true;
  var orderDate = DateTime.now();
  final quantities = <int, int>{};
  final controller = ItemSearchViewController();

  @override
  void initState() {
    super.initState();

    getItems();
  }

  getItems() async {
    AppDB().getDistributorDistributions(widget.distributor).then((value) async {
      for (final item in value) await item.item.fill();

      loading = false;
      distributions = value;

      setState(() {});
    });
  }

  double get total => quantities.keys.fold(
        0.0,
        (value, element) =>
            value + distributions[element].price * quantities[element],
      );

  String _generateOrder([bool useHtml = false]) {
    final buffer = StringBuffer();
    final dateTime = DateFormat('dd MMM yyyy').format(orderDate);
    if (useHtml) {
      buffer.write("<span>Order for Bill's Place for $dateTime</span><br><br>");
    } else {
      buffer.writeln("Order for Bill's Place for $dateTime\n");
    }
    quantities.forEach((key, value) {
      if (useHtml) {
        buffer.write(
          '<span>${distributions[key].item.name} x $value</span><br>',
        );
      } else {
        buffer.writeln('${distributions[key].item.name} x $value');
      }
    });
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSent)
          return true;
        else {
          return showConfirmation(context,
              onCanceled: () => false, onConfirmed: () => true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Generate Order"),
          actions: [
            IconButton(
              icon: Image.asset(
                EmailIcon,
                color: Colors.white,
                scale: 2,
              ),
              onPressed: () async {
                await launchEmail(_generateOrder(false), widget.distributor.email);
              },
            ),
            IconButton(
              icon: Image.asset(
                SMSIcon,
                color: Colors.white,
                scale: 2,
              ),
              onPressed: () async {
                await textMe(
                    _generateOrder(), widget.distributor.phone);
              },
            ),
          ],
        ),
        floatingActionButton: quantities.isNotEmpty
            ? FloatingActionButton.extended(
                icon: Icon(CupertinoIcons.check_mark),
                label: Text(
                  'Done',
                  style: TextStyle(
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  performLazyTask(
                    context,
                    () async {
                      final items = <OrderItem>[];
                      quantities.forEach((key, value) {
                        items.add(OrderItem(
                          quantity: value,
                          completed: false,
                          price: distributions[key].price,
                          itemId: distributions[key].item.id,
                          name: distributions[key].item.name,
                        ));
                      });
                      final order = Order(
                        items: items,
                        price: total,
                        completed: false,
                        createdAt: orderDate,
                        distributor: widget.distributor,
                      )..count = items.length;

                      AppDB().placeOrder(order);
                    },
                  );
                  isSent = true;

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            : SizedBox(),
        bottomNavigationBar: Container(
          height: 115,
          color: Theme.of(context).primaryColor,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: orderDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(3000),
                  );

                  if (date != null) {
                    setState(() => orderDate = date);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Row(children: [
                    Container(
                      color: Colors.white,
                      child: Text('Order Date'),
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    ),
                    Expanded(
                      child: Text(
                        DateFormat('dd - MMM - y').format(orderDate),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(children: [
                  Expanded(
                    child: Table(
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.5),
                              child: Text(
                                'Order Items :',
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              '  ${quantities.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.5),
                              child: Text(
                                'Order Amount :',
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              '\$${total.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    icon: Icon(CupertinoIcons.add, size: 18),
                    onPressed: () async {
                      await AppNavigation.to(context, AddItems());
                      getItems();
                    },
                    label: Text(
                      'Add Item',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
            ),
          ]),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : ReorderableListView(
                header: Container(height: 10),
                onReorder: (int oldIndex, int newIndex) {
                  _replace(distributions, quantities, oldIndex, newIndex);
                  setState(() {});
                },
                children: [
                  for (var i = 0; i < distributions.length; ++i)
                    Padding(
                      key: Key(distributions[i].id.toString()),
                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                      child: FancyTile(
                        title: Text(distributions[i].item.name),
                        subtitle: Text('\$${distributions[i].price}'),
                        trailing: ConstrainedBox(
                          constraints: BoxConstraints.expand(width: 114),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(5),
                              child: Counter(onChange: (double count) {
                                if (count == 0) {
                                  quantities.remove(i);
                                } else {
                                  quantities[i] = count.toInt();
                                }

                                setState(() {});
                              }),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
      ),
    );
  }
}

void _replace(
  List<dynamic> data,
  Map<int, dynamic> qty,
  int oldIndex,
  int newIndex,
) {
  if (newIndex >= data.length) {
    --newIndex;
  }

  var placeholder = data[newIndex];
  data[newIndex] = data[oldIndex];
  data[oldIndex] = placeholder;

  bool hasNew = qty.containsKey(newIndex);
  bool hasOld = qty.containsKey(oldIndex);

  if (hasNew && hasOld) {
    var placeholder = qty[newIndex];
    qty[newIndex] = qty[oldIndex];
    qty[oldIndex] = placeholder;
  } else if (hasOld) {
    qty[newIndex] = qty[oldIndex];
    qty.remove(oldIndex);
  } else if (hasNew) {
    qty[oldIndex] = qty[newIndex];
    qty.remove(newIndex);
  }
}
