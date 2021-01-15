import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventoty_app/src/base/theme.dart';
import 'package:inventoty_app/src/models/items-model.dart';
import 'package:inventoty_app/src/ui/widgits/text_field.dart';

class GenererateOrderItems extends StatefulWidget {
  @override
  _GenererateOrderItemsState createState() => _GenererateOrderItemsState();
}

class _GenererateOrderItemsState extends State<GenererateOrderItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Items"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: AppTextField(
              icon: Icons.search,
              placeholder: "Search",
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: dummyItems.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, i) {
              return plusMinus(
                  add: () {
                    setState(() {
                      dummyItems[i].itemValue++;
                    });
                    return dummyItems[i].itemValue;
                  },
                  subtract: () {
                    setState(() {
                      dummyItems[i].itemValue--;
                    });
                    return dummyItems[i].itemValue;
                  },
                  name: dummyItems[i].itemName,
                  value: dummyItems[i].itemValue.toString());
            },
          )),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Total Product: 21 ",
                        style: GoogleFonts.quicksand(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Total Distributors: 30",
                      style: GoogleFonts.quicksand(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(6),
                      elevation: 6,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          "Submit",
                          style: GoogleFonts.quicksand(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          )
        ],
      ),
    );
  }

  Widget plusMinus({String name, var value, Function add, Function subtract}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        padding: EdgeInsets.all(10),
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
              Text(
                name,
                style: GoogleFonts.quicksand(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.remove,
                          color:Theme.of(context).primaryColor,
                        ),
                        onPressed: subtract),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 8),
                        child: Text(
                          value,
                          style: GoogleFonts.quicksand(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white),
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: add),
                  ),
                ],
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ),
    );
  }
}
