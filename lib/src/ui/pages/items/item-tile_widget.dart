import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/models/item.dart';
import 'package:orderguide/src/ui/pages/items/add-items_page.dart';

class ItemTile extends StatefulWidget {
  final Item item;
  ItemTile({this.item});
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey[500].withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  widget.item.name[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                widget.item.name,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
