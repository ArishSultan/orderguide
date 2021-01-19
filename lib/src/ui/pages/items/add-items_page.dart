import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderguide/src/base/keys.dart';
import 'package:orderguide/src/base/theme.dart';
import 'package:orderguide/src/models/distributors-model.dart';
import 'package:orderguide/src/models/items-model.dart';
import 'package:orderguide/src/ui/widgets/item-price_dialog.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';

class AddItems extends StatefulWidget {
  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  final _key = GlobalKey<FormState>();
  List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(dummyItems.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add an Item"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppTextField(
                  icon: Icons.assignment_sharp,
                  placeholder: " Item Name",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 10),
                  child: Text("Choose Distributors",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, i) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[500].withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        activeColor: Colors.white,
                        checkColor: AppTheme.primaryColor,
                        // title: Text(
                        //   dummyDistributor[i].name + "${i+1}",
                        //   style: GoogleFonts.quicksand(
                        //       color: Theme.of(context).primaryColor,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        // value: dummyDistributor[i].isChecked,
                        // onChanged: (val) {
                        //   setState(
                        //     () {
                        //       dummyDistributor[i].isChecked = val;
                        //       showDialog(context: context,builder: (context){
                        //         return ItemPriceDialog();
                        //       });
                        //     },
                        //   );
                        // },
                      ),
                    ),
                  );
                },
              )),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 10, left: 10),
                child: TextButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                      //dummyDistributor.add(distributorsModel);
                      Navigator.of(context).pop();
                    }

                    //    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>InventoryHomePage()));
                  },
                  style: TextButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Theme.of(context).accentColor),
                  child: Text("Submit",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
