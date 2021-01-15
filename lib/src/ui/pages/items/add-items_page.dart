import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventoty_app/src/base/keys.dart';
import 'package:inventoty_app/src/base/theme.dart';
import 'package:inventoty_app/src/models/distributors-model.dart';
import 'package:inventoty_app/src/models/items-model.dart';
import 'package:inventoty_app/src/ui/widgits/text_field.dart';
import 'package:inventoty_app/src/utils/validators.dart';
import 'package:unicons/unicons.dart';

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
        title: Text("Add Items"),
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
                  icon: UniconsLine.search,
                  placeholder: " Item Name",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: dummyDistributor.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                        title: Text(
                          dummyDistributor[i].distributorName,
                          style: GoogleFonts.quicksand(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        value: dummyDistributor[i].isChecked,
                        onChanged: (val) {
                          setState(
                            () {
                              dummyDistributor[i].isChecked = val;
                            },
                          );
                        },
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
