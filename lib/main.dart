import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderguide/src/ui/pages/auth/sign-in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orderguide/src/ui/pages/homepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/utils/auth-utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Future manageUserState(BuildContext context) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool rememberMe = _prefs.getBool('rememberMe');
  DateTime lastLogin =  _prefs.getString('lastLogin') !=null ? DateTime.tryParse(_prefs.getString('lastLogin')) : null;
  if(rememberMe !=null && !rememberMe) {
    if(lastLogin !=null){
      print("Difference  ${DateTime.now().difference(lastLogin).inDays > 0}");
      if(DateTime.now().difference(lastLogin).inDays > 0){
        context.read<AuthenticationService>().signOut();
      }
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Order Guide',
        theme: ThemeData(
          textTheme: GoogleFonts.quicksandTextTheme(),
          primaryColor:Colors.blue[800],
          accentColor:Colors.red[800],),
          debugShowCheckedModeBanner: false,
               home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return InventoryHomePage();
    }
    return SignInPage();
  }
}