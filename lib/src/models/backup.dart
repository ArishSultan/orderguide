import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orderguide/src/models/_model.dart';

class Backup extends Model{
  String id;
  Timestamp date;
  String url;

  Backup({this.date,this.url,this.id}):super(id: id);

  Backup.fromJson(Map<String,dynamic> json){
    id = json['id'];
    date = json['date'];
    url = json['url'];
  }

  Map<String,dynamic> toJson() => {'date' : date,'url' : url};
}