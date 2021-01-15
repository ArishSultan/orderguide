import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventoty_app/src/base/theme.dart';
import 'package:inventoty_app/src/models/items-model.dart';
import 'package:inventoty_app/src/ui/pages/distributors/add-distributors_page.dart';
import 'package:inventoty_app/src/ui/pages/items/add-items_page.dart';
import 'package:inventoty_app/src/ui/widgits/custom-list_widget.dart';
import 'package:inventoty_app/src/ui/widgits/text_field.dart';
import 'package:unicons/unicons.dart';

class ItemsList extends StatefulWidget {
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(),
      body: dummyItems.isEmpty
          ? Center(
              child: Text("No Item Found"),
            )
          : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: AppTextField(
                  icon: UniconsLine.search,
                  placeholder: " Item Name",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),

              Expanded(
                child: ListView.builder(
                    itemCount: dummyItems.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, i) {
                      return CustomChild(
                        editTap: () => print("d"),
                        title: dummyItems[i].itemName,
                        deleteTap: () {
                          setState(() {
                            dummyItems.removeAt(i);
                          });
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("${dummyItems[i].itemName} is Removed")));
                        },
                      );
                    }),
              ),
            ],
          ),
      //ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddItems()));

          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
