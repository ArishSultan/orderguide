import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/models/distributors-model.dart';
import 'package:orderguide/src/models/items-model.dart';
import 'package:orderguide/src/ui/pages/items/add-items_page.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';
import 'package:unicons/unicons.dart';
import 'item-tile_widget.dart';

class ItemsList extends StatefulWidget {
  final Distributor distributor;
  ItemsList({this.distributor});
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.distributor == null ? "Items" : widget.distributor.name + " Items"),
      ),
      body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: AppTextField(
                  icon: UniconsLine.search,
                  placeholder: " Search Item",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: dummyItems.length,
                    itemBuilder: (context, i) {
                      return ItemTile(
                        item: dummyItems[i],
                      );
                    }),
              ),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         await AppNavigation.to(context, AddItems());
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
