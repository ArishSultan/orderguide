
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  //static const name = 'Order Guide';

  static Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(App());
  }

  @override
  Widget build(BuildContext context) {

    return Theme(
      child: CupertinoApp(
       // title: Text(data),
      ),
    );
  }
}
