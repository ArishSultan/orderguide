import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderguide/src/base/theme.dart';
import 'package:orderguide/src/models/item.dart';
import 'package:orderguide/src/ui/views/item_search_view.dart';
import 'package:orderguide/src/utils/lazy_task.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';
import 'package:orderguide/src/models/item_distribution.dart';
import 'package:orderguide/src/ui/widgets/item-price_dialog.dart';
import 'package:orderguide/src/utils/validators.dart';

class AddItems extends StatefulWidget {
  final Item item;

  AddItems([this.item]);

  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  final _key = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = ItemSearchViewController();
  final distributions = <int, ItemDistribution>{};

  Item _item;

  _fetchDistributors() async {
    /// Fetch all the previous distributions will only be executed in case
    /// of update / edit.
    if (_item.id != null) {
      print('here');
      final _distributions = await AppDB().getItemDistributions(_item);
      print(_distributions);

      _distributions.forEach((element) {
        print(_item.id);
        print(element.distributor.id);
        distributions[element.distributor.id] = element;
      });
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _item = widget.item ?? Item();
    _fetchDistributors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(centerTitle: true, title: Text("Add an Item")),
      backgroundColor: Colors.white,
      bottomNavigationBar: Material(
        elevation: 10,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: TextButton(
            onPressed: () async {
              if (_key.currentState.validate()) {
                _key.currentState.save();

                /// Fetch all previous ones.
                final oldDistributions =
                    distributions.values.where((element) => element.id != null);

                final _distributions = distributions.values
                    .where((element) => element.price != null)
                    .toList();

                _distributions.addAll(oldDistributions);

                if (_distributions.isEmpty) {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Select at least 1 distributor'),
                  ));
                  return;
                }

                await performLazyTask(context, () async {
                  if (_item.id != null) {
                    await AppDB().updateItem(_item);
                  } else {
                    _item.id = await AppDB().addItem(_item);
                  }

                  for (final dist in _distributions) {
                    if (dist.id != null) {
                      if (dist.price == null) {
                        AppDB().deleteDistribution(dist);
                      } else {
                        AppDB().updateDistribution(dist);
                      }
                    } else if (dist.price != null) {
                      await AppDB().addDistribution(dist);
                    }
                  }
                });

                Navigator.of(context).pop();
              }
            },
            style: TextButton.styleFrom(
              shape: StadiumBorder(),
              primary: Colors.white,
              minimumSize: Size.fromHeight(50),
              backgroundColor: Theme.of(context).accentColor,
            ),
            child: Text('Submit'),
          ),
        ),
      ),
      body: Form(
        key: _key,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (
            BuildContext context,
            bool innerBoxIsScrolled,
          ) {
            return [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                sliver: SliverToBoxAdapter(
                  child: AppTextField(
                    placeholder: "Item Name",
                    icon: Icons.assignment_sharp,
                    initialValue: _item.name,
                    validator: Validators.required,
                    onSaved: (val) => _item.name = val,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Choose Distributors",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ];
          },

          body: ItemSearchView<Distributor>(
            allowSearch: false,
            onFetch: AppDB().getDistributors,
            emptyMessage: 'No Distributors Registered',
            builder: (context, item, _) {
              var status = false;
              ItemDistribution distribution;

              print('index: $_, id: ${item.id}');
              print(distributions);
              if (!distributions.containsKey(item.id)) {
                distribution = distributions[item.id] =
                    ItemDistribution(item: _item, distributor: item);
              } else {
                distribution = distributions[item.id];
                status = distribution.price != null;
              }

              return Container(
                margin: const EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[500].withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CheckboxListTile(
                  activeColor: Colors.white,
                  checkColor: AppTheme.primaryColor,
                  title: Text(
                    item.name,
                    style: GoogleFonts.quicksand(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: status ? Text('\$${distribution.price}') : null,
                  value: status,
                  onChanged: (val) async {
                    final price = await showDialog(
                      context: context,
                      builder: (context) => ItemPriceDialog(
                        price: distribution.price,
                      ),
                    );
                    setState(() => distribution.price = price);
                  },
                ),
              );
            },
            controller: controller,
          ),
        ),
      ),
    );
  }
}
