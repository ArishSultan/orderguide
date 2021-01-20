import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/ui/pages/generate_orders/generate-order_items.dart';
import 'package:orderguide/src/ui/pages/items/items-list_page.dart';
import 'package:orderguide/src/ui/widgets/simple_future.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';
import 'package:unicons/unicons.dart';
import '../../../models/distributor.dart';
import 'package:orderguide/src/ui/pages/distributors/add-distributors_page.dart';
import 'distributor-tile_widget.dart';

class DistributorsList extends StatefulWidget {
  final bool forOrder;

  DistributorsList([this.forOrder = false]);

  @override
  _DistributorsListState createState() => _DistributorsListState();
}

class _DistributorsListState extends State<DistributorsList> {
  Future<List<Distributor>> distributors = Future.value([]);

  _fetchData([String search]) {
    setState(() {
      distributors = AppDB().getDistributors(search);
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
        elevation: 0,
        centerTitle: true,
        title: Text("Distributors"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            titleSpacing: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 13),
                child: AppTextField(
                  icon: UniconsLine.search,
                  placeholder: " Search Item",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (str) {
                    print(str);
                    _fetchData(str);
                  },
                ),
              ),
            ),
          ),
          SimpleFutureBuilder<List<Distributor>>(
            future: distributors,
            errorBuilder: (context, error) {
              return SliverFillRemaining(
                child: Center(child: Text(error.toString())),
              );
            },
            unknownBuilder: (context) {
              return const SliverFillRemaining(
                child: Center(child: Text('No Connection')),
              );
            },
            loadingBuilder: (context, _) {
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            builder: (context, List<Distributor> distributors) {
              if (distributors.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('No Distributors Registered'),
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return DistributorTile(
                        item: distributors[index],
                        onTap: () {
                          if (widget.forOrder) {
                            AppNavigation.to(context, GenerateOrderItems());
                          } else {
                            AppNavigation.to(context,
                                ItemsList(distributor: distributors[index]));                          }
                        },
                      );
                    },
                    childCount: distributors.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: widget.forOrder
          ? null
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await AppNavigation.to(context, AddDistributors());
                _fetchData();
              },
            ),
    );
  }
}
