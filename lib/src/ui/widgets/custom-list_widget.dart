import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderguide/src/models/distributor.dart';
import '../../base/nav.dart';
import '../pages/items/items-list_page.dart';

class CustomChild extends StatefulWidget {
  Distributor model;
  int itemCount;
  Function editTap;
  Function deleteTap;
  String title;

  CustomChild({this.itemCount, this.title, this.editTap, this.deleteTap,this.model});

  @override
  _CustomChildState createState() => _CustomChildState();
}

class _CustomChildState extends State<CustomChild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Slidable(
        actionPane: SlidableBehindActionPane(),

        // delegate: SlidableDrawerDelegate(),
        actionExtentRatio: 0.25,

        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.green,
            icon: Icons.edit,
            onTap: widget.editTap,
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: widget.deleteTap,
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
              onTap: ()=> AppNavigation.to(context, ItemsList(distributor: widget.model)),
              contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  widget.title[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                widget.title,
                style: GoogleFonts.quicksand(
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
