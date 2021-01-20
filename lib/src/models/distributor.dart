import 'package:orderguide/src/base/db.dart';

class Distributor {
  int id;
  String name;
  String email;
  String phone;
  String salesmanName;

  Distributor({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.salesmanName,
  });

  Future<void> fill() async {
    final data = await AppDB().getDistributor(id);
    name = data.name;
    email = data.email;
    phone = data.phone;
    salesmanName = data.salesmanName;
  }
}
