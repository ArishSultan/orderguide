import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/models/order.dart';
import 'package:orderguide/src/models/order_item.dart';
import 'package:orderguide/src/ui/widgets/confirmation.dart';
import 'package:orderguide/src/utils/const.dart';
import 'package:orderguide/src/utils/lazy_task.dart';
import 'package:orderguide/src/utils/send-sms.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;
  final bool isCheckIn;

  OrderDetailPage(this.order, [this.isCheckIn = true]);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  Order order;
  var loading = true;

  @override
  void initState() {
    super.initState();

    AppDB().getOrder(widget.order.id).then((value) {
      loading = false;
      order = value;

      setState(() {});
    });
  }

  String _generateOrder([bool useHtml = false]) {
    final buffer = StringBuffer();
    final dateTime = DateFormat('dd MMM yyyy').format(order.createdAt);
    if (useHtml) {
      buffer.write("<span>Order for Bill's Place for $dateTime</span><br><br>");
    } else {
      buffer.writeln("Order for Bill's Place for $dateTime\n");
    }
    order.items.forEach((value) {
      if (useHtml) {
        buffer.write(
          '<span>${value.name} x ${value.quantity}</span><br>',
        );
      } else {
        buffer.writeln('${value.name} x ${value.quantity}');
      }
    });
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('dd MMM y').format(widget.order.createdAt)),
        actions: [
          IconButton(
            icon: Image.asset(
              EmailIcon,
              color: Colors.white,
              scale: 2,
            ),
            onPressed: () async {
              await launchEmail(_generateOrder(false), order.distributor.email);
            },
          ),
          IconButton(
            icon: Image.asset(
              SMSIcon,
              color: Colors.white,
              scale: 2,
            ),
            onPressed: () async {
              await textMe(_generateOrder(), order.distributor.phone);
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.red.shade900,
          ),
          child: Text(
            widget.isCheckIn ? 'Save Order' : 'Reorder',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            if (widget.isCheckIn) {
              await performLazyTask(
                context,
                    () {
                  for (final item in order.items) {
                    if (item.completed) {
                      AppDB().markOrderItemAsComplete(item);
                    }
                  }

                  return AppDB().markOrderAsComplete(order);
                },
              );

              Navigator.of(context).pop();
            } else {
              var res;
              final result = await showConfirmation(context, onConfirmed: () => true);
              if (result) res = await AppDB().placeOrder(order..completed = false);

              print('ID BEFORE ${order.id}');
              print('ID AFTER $res');
            }
          },
        ),
      ),
      body: loading
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.0),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x08000000),
                          offset: Offset(0, 25),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            order.distributor.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        )),
                        ...order.items.map(orderItem).toList(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 10,
                          ),
                          child: Divider(
                            thickness: 1,
                            color: Colors.black26,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TOTAL ',
                                style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                  height: 0.9333333333333333,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "\$ ${order.price}",
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  Widget orderItem(OrderItem item) {
    if (widget.isCheckIn) {
      return CheckboxListTile(
        title: Text.rich(
          TextSpan(
            text: item.name,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: '   (\$${item.price})',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              )
            ],
          ),
        ),
        value: item.completed,
        subtitle: Text('Quantity : ${item.quantity}'),
        onChanged: (val) => setState(() => item.completed = val),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 15,
                  color: const Color(0xff000000),
                  height: 0.9333333333333333,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              Text(
                'Quantity : ${item.quantity}',
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  color: const Color(0x994b41f1),
                  height: 1.1666666666666667,
                ),
                textAlign: TextAlign.left,
              )
            ],
          ),
          Spacer(),
          Column(children: [
            Text(
              '\$${item.price}',
              style: TextStyle(
                fontFamily: 'Poppins-SemiBold',
                fontSize: 15,
                color: Colors.grey,
                height: 0.9333333333333333,
              ),
              textAlign: TextAlign.left,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                  color: item.completed
                      ? Theme.of(context).primaryColor
                      : Colors.red.shade900,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                item.completed ? 'Received' : 'Not Received',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
