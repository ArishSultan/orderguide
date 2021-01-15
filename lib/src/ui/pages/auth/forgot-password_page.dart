import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventoty_app/src/ui/widgits/text_field.dart';

class ForgotPassword extends StatelessWidget {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30, 60, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logo(imgPath: "assets/images/couple4.png"),
              Text(
                'Foodee',
                style: GoogleFonts.pacifico(
                  fontSize: 30,
                  color: Color(0xfffcc522),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "let's choose your match",
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppTextField(
                  placeholder: 'Email',
                  icon: Icons.email_outlined,
                  onSaved: (email) => _sendEmail(context, email),
                //  validator: Validators.requiredEmail,
                  keyboardType: TextInputType.emailAddress,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 0),
                child: TextButton(
                  onPressed: () {
                    _key.currentState.validate();
                    _key.currentState.save();
                  },
                  //style: AppTheme.primaryButtonTheme,
                  child: Text("Confirm"),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }

  Future<void> _sendEmail(BuildContext context, String email) async {
    var error;
 //   await performLazyTask(context, () async {
   //   await AppServices()
          // .forgotPassword(email: _email)
          // .catchError((e) {
          // error = ServerError.withError(e);
          // print(error.errorMessage);
          // print(error)
          ;
      // });
    //});

    if (error != null) {
      forgetMail(
        title: 'Error',
        context: context,
        message: error.errorMessage,
        function: () {
          Navigator.of(context).pop();
        },
      );
    } else {
      forgetMail(
        function: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        title: 'Message',
        message: 'Link has been send successfully.',
        context: context,
      );
    }
  }

  forgetMail({
    BuildContext context,
    String message,
    String title,
    Function function,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: GoogleFonts.pacifico(),
          ),
          content: Text(
            message,
            style: GoogleFonts.pacifico(),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: GoogleFonts.pacifico(),
              ),
              onPressed: function,
            ),
          ],
        );
      },
    );
  }

  Widget logo({String imgPath}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Image.asset("$imgPath"),
            width: 180,
            height: 180,
          ),
        ),
      ),
    );
  }
}
