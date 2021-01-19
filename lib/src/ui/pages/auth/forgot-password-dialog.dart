import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/ui/widgets/message-dialog.dart';
import '../../../utils/lazy_task.dart';
import '../../../utils/validators.dart';
import '../../widgets/text_field.dart';

class ForgotPasswordDialog extends StatefulWidget {
  @override
  State createState() => new ForgotPasswordDialogState();
}

class ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  var _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Reset Password',
          style: TextStyle(
            // fontFamily: 'BitterRegular',
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: AppTextField(
              icon: CupertinoIcons.mail,
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: Validators.required,
              onSaved: (value) => _email = value,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Submit',
              style: TextStyle(
                fontFamily: 'BitterRegular',
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                FocusScope.of(context).requestFocus(FocusNode());
                FocusScope.of(context).requestFocus(FocusNode());
                await performLazyTask(context, () async {
                  var res;
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _email);
                  } on FirebaseException catch (e) {
                    Navigator.of(context).pop();
                    openMessageDialog(context, e.message);
                    print(e);
                    return;
                  }
                });
                Navigator.pop(context);
                openMessageDialog(
                    context, 'Please check your email for resetting password.');
              } else
                setState(() => _autoValidate = true);
            },
          ),
        ],
      ),
    );
  }
}
