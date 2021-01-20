import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

textMe(String body) async {
  if (Platform.isAndroid) {
    const uri = 'sms:+39 348 060 888?body=hello%20there';
    await launch(uri);
  } else if (Platform.isIOS) {
    // iOS
    var uri = 'sms:0039-222-060-888&body=$body';
    try{
      await launch(uri);
    } catch(e){
      print(e);
    }
  }
}