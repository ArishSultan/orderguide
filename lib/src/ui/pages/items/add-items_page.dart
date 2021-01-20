import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderguide/src/base/theme.dart';
import 'package:orderguide/src/models/item.dart';
import 'package:orderguide/src/utils/lazy_task.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';
import 'package:orderguide/src/ui/widgets/simple_future.dart';
import 'package:orderguide/src/models/item_distribution.dart';
import 'package:orderguide/src/ui/widgets/item-price_dialog.dart';
import 'package:orderguide/src/utils/validators.dart';

class AddItems extends StatefulWidget {
  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  final _item = Item();
  final _key = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Distributor>> distributors;
  List<ItemDistribution> itemDistributions;

  _fetchDistributors() async {
    distributors = AppDB().getDistributors(null);
    final all = await distributors;
    itemDistributions = List.generate(
      all.length,
      (index) => ItemDistribution(item: _item, distributor: all[index]),
    );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

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
                final distributions = itemDistributions
                    .where((element) => element.price != null)
                    .toList();

                if (distributions.isEmpty) {
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

                  for (final dist in distributions) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                sliver: SliverToBoxAdapter(
                  child: AppTextField(
                    placeholder: "Item Name",
                    icon: Icons.assignment_sharp,
                    validator: Validators.required,
                    onSaved: (val) => _item.name = val,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Choose Distributors",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                          final status = itemDistributions[index].price != null;
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
                                distributors[index].name,
                                style: GoogleFonts.quicksand(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: status
                                  ? Text('\$${itemDistributions[index].price}')
                                  : null,
                              value: status,
                              onChanged: (val) async {
                                final price = await showDialog(
                                  context: context,
                                  builder: (context) => ItemPriceDialog(
                                    price: itemDistributions[index].price,
                                  ),
                                );

                                setState(() {
                                  itemDistributions[index].price = price;
                                });
                                // if (price != null) {
                                //
                                // }
                                // if (status) {
                                //   setState(() {
                                //     itemDistributions[index].price = null;
                                //   });
                                // } else {
                                //
                                //
                                //   if (price != null) {
                                //     setState(() {
                                //       itemDistributions[index].price = price;
                                //     });
                                //   }
                                // }
                              },
                            ),
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
        ),
      ),
    );
  }
}
