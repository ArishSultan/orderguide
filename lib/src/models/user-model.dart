import 'package:orderguide/src/base/db.dart';

class UserModel {
  String email;
  String password;
  int id;

  UserModel({this.id, this.email, this.password});

  Future<void> fill() async {
    final data = await AppDB().getUser(id);
    email = data.email;
    password = data.password;
  }
}
