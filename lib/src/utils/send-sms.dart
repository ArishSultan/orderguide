import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

textMe(String body) async {
  if (Platform.isAndroid) {
    final uri = 'sms:+39 348 060 888?body=$body';
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