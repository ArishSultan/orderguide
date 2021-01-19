import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderguide/src/base/keys.dart';
import 'package:orderguide/src/base/theme.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';
import 'package:orderguide/src/utils/validators.dart';
import 'package:unicons/unicons.dart';

import '../../../models/distributors-model.dart';

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
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppTextField(
                  icon: UniconsLine.user,
                  placeholder: "Distributor Name",
                  //validator: Validators.requiredEmail,
                  onSaved: (name) => distributorsModel.name = name,
                  //  keyboardType: TextInputType.emailAddress,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppTextField(
                  icon: UniconsLine.user_square,
                  placeholder: "Salesman Name",
                  //validator: Validators.requiredEmail,
                  onSaved: (name) => distributorsModel.name = name,
                  //  keyboardType: TextInputType.emailAddress,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppTextField(
                  onSaved: (phone) =>
                      distributorsModel.phone = phone,
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
                      distributorsModel.email = email,
                  key: Keys.signInEmail,
                  icon: CupertinoIcons.mail,
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
                    Navigator.of(context).pop();
                    },
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
    );
  }
}
