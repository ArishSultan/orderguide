import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/models/item.dart';
import 'package:orderguide/src/models/item_purchase.dart';
import 'package:orderguide/src/ui/views/item_search_view.dart';
import 'package:orderguide/src/ui/widgets/fancy_tile.dart';

class ItemHistoryPage extends StatefulWidget {
  final Item item;

  ItemHistoryPage(this.item);

  @override
  _ItemHistoryPageState createState() => _ItemHistoryPageState();
}

class _ItemHistoryPageState extends State<ItemHistoryPage> {
  DateTime to;
  DateTime from;
  final controller = ItemSearchViewController();

  @override
  void initState() {
    super.initState();

    // AppDB().getOrder(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.name),centerTitle: true,),
      body: ItemSearchView<ItemPurchase>(
          controller: controller,
          emptyMessage: 'No Orders in Selected Time Span',
          header: (context, data) {
            final sum = data.fold(0, (value, element) => value + element.qty);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Total Items Purchased : ' + sum.toString(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
          onFetch: ([str]) =>
              AppDB().getItemPurchases(from, to, widget.item.id),
          builder: (context, item, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: FancyTile(
                title: Text(DateFormat('dd, MMM y').format(item.time)),
                subtitle:
                    Text('${item.qty} ${item.qty == 1 ? 'Item' : 'Items'}'),
                trailing: Text('\$${item.price}'),
              ),
            );
            return Container(child: Text(item.qty.toString()));
          }),
      bottomNavigationBar: Container(
        height: 100,
        color: Theme.of(context).primaryColor,
        child: Column(children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(children: [
              Expanded(
                child: Text.rich(TextSpan(
                  text: 'From :  ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    if (from != null)
                      TextSpan(text: DateFormat('dd MMM y').format(from))
                    else
                      TextSpan(
                        text: 'Not Specified',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                  ],
                )),
              ),
              Expanded(
                child: Text.rich(TextSpan(
                  text: 'To :  ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    if (to != null)
                      TextSpan(text: DateFormat('dd MMM y').format(to))
                    else
                      TextSpan(
                        text: 'Not Specified',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                  ],
                )),
              )
            ]),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: 40),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.red.shade900,
                ),
                icon: Icon(CupertinoIcons.calendar, size: 20),
                label: Text(
                  'Select Time Span',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  final range = await showDateRangePicker(
                    context: context,
                    initialDateRange: to != null && from != null
                        ? DateTimeRange(start: from, end: to)
                        : null,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000),
                  );

                  if (range != null) {
                    to = range.end;
                    from = range.start;
                    setState(() {});
                    controller.refresh();
                  }
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
