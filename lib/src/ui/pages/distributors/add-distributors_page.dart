import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderguide/src/base/keys.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/models/distributors-model.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';
import 'package:orderguide/src/utils/lazy_task.dart';
import 'package:orderguide/src/utils/validators.dart';
import 'package:unicons/unicons.dart';

class AddDistributors extends StatefulWidget {
  @override
  _AddDistributorsState createState() => _AddDistributorsState();
}

class _AddDistributorsState extends State<AddDistributors> {
  final _key = GlobalKey<FormState>();
  final _distributor = Distributor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Distributor"),
      ),
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
                  validator: Validators.required,
                  onSaved: (name) => _distributor.name = name,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppTextField(
                  icon: UniconsLine.user_square,
                  placeholder: "Salesman Name",
                  validator: Validators.required,
                  onSaved: (name) => _distributor.salesmanName = name,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppTextField(
                  onSaved: (phone) => _distributor.phone = phone,
                  icon: UniconsLine.phone,
                  placeholder: "Phone",
                  validator: Validators.multiple([
                    Validators.required,
                    Validators.contact,
                  ]),
                  keyboardType: TextInputType.phone,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppTextField(
                  onSaved: (email) => _distributor.email = email,
                  key: Keys.signInEmail,
                  icon: CupertinoIcons.mail,
                  placeholder: "Email",
                  validator: Validators.requiredEmail,
                  keyboardType: TextInputType.emailAddress,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextButton(
                  key: Keys.signInButton,
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();

                      await performLazyTask(
                        context,
                        () => AppDB().addDistributor(_distributor),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
