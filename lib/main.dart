import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderguide/src/ui/pages/auth/sign-in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Guide',
      theme: ThemeData(
        textTheme: GoogleFonts.quicksandTextTheme(),
        primaryColor:Colors.blue[800],
        accentColor:Colors.red[800],),
        debugShowCheckedModeBanner: false,
             home: SignInPage(),
    );
  }
}