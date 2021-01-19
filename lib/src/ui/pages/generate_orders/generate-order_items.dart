import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/models/item.dart';
import 'package:orderguide/src/ui/widgets/counter.dart';
import 'package:orderguide/src/ui/widgets/date_picker_field.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';
import 'package:orderguide/src/utils/const.dart';
import 'package:orderguide/src/utils/send-sms.dart';
import '../../../base/nav.dart';
import '../items/add-items_page.dart';
import 'package:intl/intl.dart';

class GenererateOrderItems extends StatefulWidget {
  @override
  _GenererateOrderItemsState createState() => _GenererateOrderItemsState();
}

class _GenererateOrderItemsState extends State<GenererateOrderItems> {
  List<Item> orderItems = [];
  DateTime orderDate = DateTime.now();


  @override
  void initState() {
    super.initState();
    orderItems = dummyItems;
  }

  String _total(){
    double sum = 0;
    dummyItems.where((element) => element.quantity > 0).forEach((element) {
      sum+=element.price * element.quantity;
    });
    return sum.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Generate Order"),
        actions: [
          IconButton(icon: Icon(Icons.alternate_email_outlined), onPressed: (){

          }),
          IconButton(icon: Image.asset(SMSIcon,color: Colors.white,scale: 2,),
              onPressed: () async {
                String order = "Order for Bill's Place for ${DateFormat('dd MMM yyyy').format(orderDate)} \n";
            orderItems.where((element) => element.quantity > 0).forEach((element) {
              order+= "${element.name} x ${element.quantity} \n";
            });
              await textMe(Uri.encodeFull(order));
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:12,right: 12,top: 15),
            child: DatePickerFormField(
              label: 'Order Date',
              onChanged: (DateTime date){
                setState(() {
                  orderDate = date;
                });
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: AppTextField(
              icon: Icons.search,
              placeholder: "Search Item",
            ),
          ),
          Expanded(
            child: ReorderableListView(
              children: <Widget>[
                for(final item in orderItems)
                  orderItem(item)
              ],
              onReorder: reorderData,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
            ),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Total Items: ${orderItems.where((element) => element.quantity > 0).length} ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Order Amount: \$${_total()}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Padding(
                  padding: const EdgeInsets.only(right:10.0,bottom: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                        shape: StadiumBorder(),
                        textColor: Colors.white,
                        color: Colors.red[900],
                        onPressed: ()=> AppNavigation.to(context, AddItems()),
                        child:Text("Add Item")),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  void reorderData(int oldindex, int newindex){
    setState(() {
      if(newindex>oldindex){
        newindex-=1;
      }
      final items = orderItems.removeAt(oldindex);
      orderItems.insert(newindex, items);
    });
  }

  void sorting(){
    setState(() {
      orderItems.sort();
    });
  }

  Widget orderItem(Item item) {
    return Padding(
      key: Key(item.name),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey[500].withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            children: <Widget>[
              Icon(CupertinoIcons.list_bullet),
              Expanded(flex:1,child: Container()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${item.price}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Expanded(flex:7,child: Container()),
              Counter(
                 onChange: (double val){
                   setState(() {
                     item.quantity = val.round();
                   });
                 })
            ],
          ),
        ),
      ),
    );
  }
}
