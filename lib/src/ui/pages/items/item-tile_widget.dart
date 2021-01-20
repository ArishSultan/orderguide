import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/models/item.dart';
import 'package:orderguide/src/ui/pages/items/add-items_page.dart';

class ItemTile extends StatefulWidget {
  final Item item;
  ItemTile(this.item);
  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Slidable(
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.green,
            icon: Icons.edit,
            onTap: (){
              AppNavigation.to(context, AddItems());
            },
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: (){},
          ),
        ],
        child: Padding(

        ),
      ),
    );
  }
}
