import 'dart:io';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';

// textMe(String body, String phone) async {
//   if (Platform.isAndroid) {
//     final uri = 'sms:$phone?body=$body';
//     await launch(uri);
//   } else if (Platform.isIOS) {
//     print(body);
//     // iOS
//     var uri = 'sms:$phone&body=${body}';
//     try {
//       await launch(uri);
//     } catch (e) {
//       print(e);
//     }
//   }
// }

textMe(String body, String phone) async {
  bool _result = await launchSms(message: body, number: phone)
      .catchError((onError) {
    print(onError);
  });
}

launchEmail(String body, String email) async {
  try {
    final _email = Email(
      body: body,
      // isHTML: true,
      recipients: [email],
      subject: "Order For Bill's Place",
    );

    await FlutterEmailSender.send(_email);
  } catch (e) {
    print(e.toString());
  }
}
