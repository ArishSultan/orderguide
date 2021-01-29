import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orderguide/src/service/firebasefirestore-service.dart';
import 'package:orderguide/src/models/backup.dart';

class BackupService extends FirestoreService<Backup> {
  @override
  String get collectionName => 'backups';

  @override
  Backup parseModel(DocumentSnapshot document) {
    return Backup.fromJson(document.data())..id = document.id;
  }

  Future<Backup> getLatestBackup(){
    return super.fetchOneFirestore('backup');
  }
}
