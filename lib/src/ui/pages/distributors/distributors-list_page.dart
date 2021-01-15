import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventoty_app/src/base/theme.dart';
import 'file:///C:/Users/Osama/Workspace/Sparco%20Projects/inventoty_app/lib/src/models/distributors-model.dart';
import 'package:inventoty_app/src/ui/pages/distributors/add-distributors_page.dart';
import 'package:inventoty_app/src/ui/widgits/custom-list_widget.dart';
import 'package:inventoty_app/src/ui/widgits/text_field.dart';
import 'package:unicons/unicons.dart';

class DistributorsList extends StatefulWidget {
  @override
  _DistributorsListState createState() => _DistributorsListState();
}

class _DistributorsListState extends State<DistributorsList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Distributors"),
      ),
      body: dummyDistributor.isEmpty
          ? Center(
              child: Text("No Item Found"),
            )
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: AppTextField(
                    icon: UniconsLine.search,
                    placeholder: "Distributor Name",
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, i) {
                      return CustomChild(
                        editTap: () => print("d"),
                        deleteTap: () {
                          setState(() {
                            dummyDistributor.removeAt(i);
                          });

                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "${dummyDistributor[i].distributorName} is Removed")));
                        },
                        title:
                            dummyDistributor[i].distributorName + ' ${i + 1}',
                      );
                    },
                    itemCount: dummyDistributor.length,
                  ),
                ),
              ],
            ),
      //ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddDistributors()));

          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
