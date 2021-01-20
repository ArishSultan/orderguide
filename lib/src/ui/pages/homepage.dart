import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderguide/src/ui/pages/distributors/distributors-list_page.dart';
import 'package:orderguide/src/ui/pages/generate_orders/generate-order_distributors.dart';
import 'package:orderguide/src/ui/widgets/home-tile.dart';
import 'package:orderguide/src/utils/const.dart';
import '../../base/nav.dart';
import '../../base/nav.dart';
import 'history/history_listing.dart';
import 'items/items-list_page.dart';

class InventoryHomePage extends StatefulWidget {
  @override
  _InventoryHomePageState createState() => _InventoryHomePageState();
}

class _InventoryHomePageState extends State<InventoryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.blue[800],
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/inventory.png",
          scale: 2,
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeTile(
              image: ItemsIcon,
              title: 'Items',
              onTap: () => AppNavigation.to(context, ItemsList()),
            ),
            HomeTile(
              image: DistributorsIcon,
              title: 'Distributors',
              onTap: () => AppNavigation.to(context, DistributorsList()),
            ),
            HomeTile(
              image: OrdersIcon,
              title: 'Generate Order',
              onTap: () => AppNavigation.to(context, DistributorsList()),
            ),
            HomeTile(
              image: HistoryIcon,
              title: 'History',
              onTap: () => AppNavigation.to(context, HistoryListing()),
            ),
          ],
        ),
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
