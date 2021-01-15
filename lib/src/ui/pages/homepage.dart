
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventoty_app/src/base/theme.dart';
import 'package:inventoty_app/src/ui/pages/distributors/distributors-list_page.dart';
import 'package:inventoty_app/src/ui/pages/generate_orders/generate-order_distributors.dart';

import 'items/items-list_page.dart';

class InventoryHomePage extends StatefulWidget {
  @override
  _InventoryHomePageState createState() => _InventoryHomePageState();
}

class _InventoryHomePageState extends State<InventoryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Home Page"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          gridView(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ItemsList()));
              },
              text: "Items",
              imgPath: "items.jpg"),
          gridView(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DistributorsList()));
              },
              text: "Distributors",
              imgPath: "distributors.jpeg"),
          gridView(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GenerateOrderDistributorsList()));
              },
              text: "Generate Orders",imgPath: "order.jpg"),
        ],
      ),
    );
  }

  Widget gridView({String text, Function onTap, String imgPath}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.red.withOpacity(0.2), BlendMode.dstATop),
                    image: AssetImage("assets/images/$imgPath"))),
            child: Center(
              child: ShaderMask(
                shaderCallback: (bounds) => RadialGradient(
                    center: Alignment.centerLeft,
                    tileMode: TileMode.mirror,
                    colors: [
                      Colors.red[900],
                      Colors.blue[900],
                    ]).createShader(bounds),
                child: Text(
                  text,
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
