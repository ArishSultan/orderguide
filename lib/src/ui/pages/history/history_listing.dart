import 'package:flutter/material.dart';
import 'package:orderguide/src/base/nav.dart';

import 'order-detail_page.dart';

class HistoryListing extends StatefulWidget {
  @override
  _HistoryListingState createState() => _HistoryListingState();
}

class _HistoryListingState extends State<HistoryListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders History"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           HistoryTile(),
           HistoryTile(),
           HistoryTile(),
          ],
        ),
      ),
    );
  }
}


class HistoryTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: ()=> AppNavigation.to(context, OrderDetailPage()),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 1,
                      color: Colors.grey.shade200
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
                        Text("Panos Foods"),
                        Text("18, January 2021",style: TextStyle(
                          color: Colors.grey
                        ),),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("16 Items"),
                        Text("\$100.00"),
                      ],
                    ),
                    trailing:  Icon(Icons.chevron_right,color: Color.fromRGBO(75, 68, 206, 1),size: 35,),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}