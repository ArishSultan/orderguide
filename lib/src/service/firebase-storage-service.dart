import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseStorageService {
  static Future<String> uploadBackup(String path) async {
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(DateTime.now().toIso8601String()+'.sqlite');
    UploadTask uploadTask = firebaseStorageRef.putFile(File(path));
    var url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }
}
