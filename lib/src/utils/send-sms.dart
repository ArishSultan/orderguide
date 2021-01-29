import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

textMe(String body,String phone) async {
  if (Platform.isAndroid) {
    final uri = 'sms:$phone?body=$body';
    await launch(uri);
  } else if (Platform.isIOS) {
    // iOS
    var uri = 'sms:$phone&body=$body';
    try{
      await launch(uri);
    } catch(e){
      print(e);
    }
  }
}

launchEmail(String body,String email) async {
  try{
    // ios specification
    final String subject = "Order For Bill's Place";
    final String stringText = body;
    String uri = 'mailto:$email?subject=${subject}&body=${stringText}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print("No email client found");
    }
  } catch (e){
    print(e.toString());
  }

}