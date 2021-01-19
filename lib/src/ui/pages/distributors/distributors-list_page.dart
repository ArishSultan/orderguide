import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/base/nav.dart';
import '../../../models/distributors-model.dart';
import 'package:orderguide/src/ui/pages/distributors/add-distributors_page.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';
import 'package:unicons/unicons.dart';
import 'distributor-tile_widget.dart';

class DistributorsList extends StatefulWidget {
  @override
  _DistributorsListState createState() => _DistributorsListState();
}

class _DistributorsListState extends State<DistributorsList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Distributors"),
      ),
      body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: AppTextField(
                    icon: UniconsLine.search,
                    placeholder: "Search Distributor",
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      return DistributorTile(item: dummyDistributor[i],);
                    },
                    itemCount: dummyDistributor.length,
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          AppNavigation.to(context, AddDistributors());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
