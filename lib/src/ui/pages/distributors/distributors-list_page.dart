import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/ui/widgets/simple_future.dart';
import '../../../models/distributors-model.dart';
import 'package:orderguide/src/ui/pages/distributors/add-distributors_page.dart';
import 'distributor-tile_widget.dart';

class DistributorsList extends StatefulWidget {
  @override
  _DistributorsListState createState() => _DistributorsListState();
}

class _DistributorsListState extends State<DistributorsList> {
  Future<List<Distributor>> distributors = Future.value([]);

  _fetchData() {
    setState(() {
      distributors = AppDB().getDistributors();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Distributors"),
      ),
      body: SimpleFutureBuilder<List<Distributor>>(
        future: distributors,
        builder: (context, List<Distributor> distributors) {
          if (distributors.isEmpty) {
            return const Center(child: Text('No Distributors Registered'));
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => DistributorTile(distributors[index]),
              itemCount: distributors.length,
            );
          }
        },
      ),
      // Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      //       child: AppTextField(
      //         icon: UniconsLine.search,
      //         placeholder: "Search Distributor",
      //         autoValidateMode: AutovalidateMode.onUserInteraction,
      //       ),
      //     ),
      //     Expanded(
      //       child:
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await AppNavigation.to(context, AddDistributors());
          _fetchData();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
