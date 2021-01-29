import 'package:firebase_auth/firebase_auth.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/base/db.dart';
import 'package:orderguide/src/models/user-model.dart';
import 'package:orderguide/src/utils/lazy_task.dart';
import 'package:orderguide/src/base/keys.dart';
import 'package:orderguide/src/base/nav.dart';
import 'package:orderguide/src/ui/pages/auth/forgot-password-dialog.dart';
import 'package:orderguide/src/ui/pages/homepage.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';
import 'package:orderguide/src/utils/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _key = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences _preferences;
  var autoValidate = AutovalidateMode.disabled;
  bool rememberMe = true;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  UserModel _data = UserModel();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) => _preferences = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Form(
          key: _key,
          autovalidateMode: autoValidate,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(30, 60, 30, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                logo(imgPath: "assets/images/inventory.png"),
                RichText(
                  text: TextSpan(
                      text: "Inventory ",
                      style: GoogleFonts.pacifico(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[900],
                      ),
                      children: [
                        TextSpan(
                            text: "Purchasing",
                            style: GoogleFonts.pacifico(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            )),
                        TextSpan(
                            text: " Guide",
                            style: GoogleFonts.pacifico(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900],
                            ))
                      ]),
                ),
                SizedBox(height: 10),
                AppTextField(
                  key: Keys.signInEmail,
                  icon: UniconsLine.user,
                  placeholder: "Email",
                  validator: Validators.requiredEmail,
                   onSaved: (email) => _data.email = email,
                  keyboardType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: AppTextField.password(
                    key: Keys.signInPassword,
                    placeholder: "Password",
                    icon: UniconsLine.lock_open_alt,
                    validator: Validators.requiredPassword,
                    autoValidateMode: autoValidate,
                     onSaved: (password) => _data.password = password,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(value: rememberMe,
                        onChanged: (bool val){
                      setState(() {
                        rememberMe = val;
                      });
                    }),
                    Text("Remember me?")
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only( bottom: 15),
                  child: TextButton(
                    key: Keys.signInButton,
                    onPressed: () async {
                      if(_key.currentState.validate()){
                        _key.currentState.save();
                        await performLazyTask(context, () async {
                          try{
                            UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: _data.email.trim(), password: _data.password);
                            User user= userCredential.user;
                            await _preferences.setBool('rememberMe', rememberMe);
                            await _preferences.setString('lastLogin', DateTime.now().toIso8601String());

                            AppNavigation.to(context, InventoryHomePage(),replace: true);
                          }
                          on FirebaseAuthException catch(error) {
                            Navigator.pop(context);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(error.message),
                              duration: Duration(seconds: 2),
                            ));
                            return;
                          }
                        });
                      } else{
                        setState(() {
                          autoValidate = AutovalidateMode.always;
                        });
                      }

                    },
                    style: TextButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size.fromHeight(50),
                        backgroundColor: Theme.of(context).accentColor),
                    child: Text("Sign in",style: GoogleFonts.quicksand(color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: GestureDetector(
          key: Keys.forgotPasswordButton,
          onTap: () => showDialog(context: context,builder:(ctx)=> ForgotPasswordDialog()),
          child: Text(
            "Forgot Password?",
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  _signIn() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      // AppServices().signIn(_data);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => InventoryHomePage()));
    }
  }

  invalidUser(String message, bool isEmail) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Error',
            textAlign: TextAlign.center,
            style: GoogleFonts.pacifico(
              fontWeight: FontWeight.bold,
              color: Colors.brown,
              fontSize: 24,
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.brown,
                ),
                child: Text(
                  'OK',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: Navigator.of(context).pop,
              ),
            ),
            if (isEmail) TextButton(child: Text('Resend'), onPressed: _resend),
          ],
        );
      },
    );
  }

  _resend() async {
    // Navigator.of(context).pop();
    // await performLazyTask(context, () async {
    //   await FoodeeService().resendEmail(email: _email).catchError((e) {
    //     print(e);
    //   });
    // });
  }

  Widget logo({String imgPath}) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Image.asset("$imgPath")),
    );
  }
}

//For creating temporary user
// print(await AppDB().addUser(UserModel(email: 'haroonashrafawan@gmail.com',password: '12345678')));
