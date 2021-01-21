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
import 'package:orderguide/src/ui/widgets/counter.dart';
import 'package:orderguide/src/ui/widgets/fancy_tile.dart';
import 'package:orderguide/src/utils/const.dart';
import 'package:intl/intl.dart';
import 'package:orderguide/src/utils/lazy_task.dart';

class GenerateOrderItems extends StatefulWidget {
  final Distributor distributor;

  GenerateOrderItems(this.distributor);

  @override
  _GenerateOrderItemsState createState() => _GenerateOrderItemsState();
}

class _GenerateOrderItemsState extends State<GenerateOrderItems> {
  List<ItemDistribution> distributions;

  var loading = true;
  var orderDate = DateTime.now();
  final quantities = <int, int>{};
  final controller = ItemSearchViewController();

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Generate Order"),
        actions: [
          IconButton(
            icon: Icon(Icons.alternate_email_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              SMSIcon,
              color: Colors.white,
              scale: 2,
            ),
            onPressed: () async {
              final buffer = StringBuffer();

              buffer.writeln(
                  "Order for Bill's Place for ${DateFormat('dd MMM yyyy').format(orderDate)}");
              quantities.forEach((key, value) {
                buffer.writeln('${distributions[key].item.name} x $value');
              });

              print(buffer);
              // await textMe(Uri.encodeFull(buffer.toString()));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(CupertinoIcons.add),
        label: Text(
          'Place Order',
          style: TextStyle(
            letterSpacing: 0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
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

          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ),
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
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
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
                            '\$$total',
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
                  onPressed: () => AppNavigation.to(context, AddItems()),
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
