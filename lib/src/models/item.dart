import 'package:orderguide/src/base/db.dart';

class Item {
  int id;
  String name;

  Item({this.id, this.name});

  Future<void> fill() async {
    final data = await AppDB().getItem(id);
    name = data.name;
  }
}
