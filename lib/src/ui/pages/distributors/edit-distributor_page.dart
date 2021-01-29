import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderguide/src/base/keys.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/models/distributor.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';
import 'package:orderguide/src/utils/lazy_task.dart';
import 'package:orderguide/src/utils/validators.dart';
import 'package:unicons/unicons.dart';

class EditDistributor extends StatefulWidget {
  final Distributor distributor;

  EditDistributor([this.distributor]);

  @override
  _EditDistributorState createState() => _EditDistributorState();
}

class _EditDistributorState extends State<EditDistributor> {
  Distributor distributor;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    distributor = widget.distributor ?? Distributor();
  }

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
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppTextField(
                  icon: UniconsLine.user,
                  initialValue: distributor.name,
                  placeholder: "Distributor Name",
                  validator: Validators.required,
                  onSaved: (name) => distributor.name = name,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppTextField(
                  icon: UniconsLine.user_square,
                  placeholder: "Salesman Name",
                  validator: Validators.required,
                  initialValue: distributor.salesmanName,
                  onSaved: (name) => distributor.salesmanName = name,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppTextField(
                  onSaved: (phone) => distributor.phone = phone,
                  icon: UniconsLine.phone,
                  placeholder: "Phone",
                  initialValue: distributor.phone,
                  validator: Validators.multiple([
                    Validators.required,
                    // Validators.contact,
                  ]),
                  keyboardType: TextInputType.phone,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppTextField(
                  onSaved: (email) => distributor.email = email,
                  key: Keys.signInEmail,
                  icon: CupertinoIcons.mail,
                  placeholder: "Email",
                  initialValue: distributor.email,
                  validator: Validators.requiredEmail,
                  keyboardType: TextInputType.emailAddress,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: TextButton(
                  key: Keys.signInButton,
                  onPressed: () async {
                    final isNew = distributor.id == null;

                    if (_key.currentState.validate()) {
                      _key.currentState.save();

                      await performLazyTask(
                        context,
                        () {
                          if (isNew) {
                            return AppDB().addDistributor(distributor);
                          } else {
                            return AppDB().updateDistributor(distributor);
                          }
                        },
                        message: isNew
                            ? 'Registering Distributor'
                            : 'Updating Distributor',
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
