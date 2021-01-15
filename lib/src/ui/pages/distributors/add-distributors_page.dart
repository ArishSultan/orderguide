import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventoty_app/src/base/keys.dart';
import 'package:inventoty_app/src/base/theme.dart';
import 'file:///C:/Users/Osama/Workspace/Sparco%20Projects/inventoty_app/lib/src/models/distributors-model.dart';
import 'package:inventoty_app/src/ui/widgits/text_field.dart';
import 'package:inventoty_app/src/utils/validators.dart';
import 'package:unicons/unicons.dart';

class AddDistributors extends StatefulWidget {
  @override
  _AddDistributorsState createState() => _AddDistributorsState();
}

class _AddDistributorsState extends State<AddDistributors> {
  final _key = GlobalKey<FormState>();

  DistributorsModel distributorsModel=DistributorsModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      title: Text("Add Distributor"),),
      body: Center(
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: AppTextField(
                    icon: UniconsLine.user,
                    placeholder: "Name",
                    //validator: Validators.requiredEmail,
                    onSaved: (name) => distributorsModel.distributorName = name,
                    //  keyboardType: TextInputType.emailAddress,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: AppTextField(
                    onSaved: (phone) =>
                        distributorsModel.distributorPhone = phone,
                    icon: UniconsLine.phone,
                    placeholder: "Phone",
                    keyboardType: TextInputType.phone,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: AppTextField(
                    onSaved: (email) =>
                        distributorsModel.distributorEmail = email,

                    key: Keys.signInEmail,
                    icon: UniconsLine.user,
                    placeholder: "Email",
                    validator: Validators.requiredEmail,
                    //  onSaved: (email) => _data.username = email,
                    keyboardType: TextInputType.emailAddress,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextButton(
                    key: Keys.signInButton,
                    onPressed: () {
                      Navigator.of(context).pop();     },
                    style: TextButton.styleFrom(

                        shape: StadiumBorder(),
                        minimumSize: Size.fromHeight(50),

                        backgroundColor: Theme.of(context).accentColor),
                    child: Text("Submit",style: GoogleFonts.quicksand(color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
