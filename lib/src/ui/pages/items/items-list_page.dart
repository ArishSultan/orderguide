import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/models/item.dart';
import 'package:orderguide/src/ui/pages/items/add-items_page.dart';
import 'package:orderguide/src/ui/widgets/simple_future.dart';
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
  Future<List<Item>> items;

  void _fetchData([String search]) {
    setState(() {
      items = AppDB().getItems(search);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.distributor == null
            ? "Items"
            : widget.distributor.name + " Items"),
      ),
      body:
      CustomScrollView(
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
          SimpleFutureBuilder<List<Item>>(
            future: items,
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
            builder: (context, List<Item> items) {
              if (items.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('No Items Registered'),
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return ItemTile(items[index]);
                    },
                    childCount: items.length,
                  ),
                );
              }
            },
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
