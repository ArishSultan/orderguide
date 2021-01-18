
class DistributorsModel{
  String name;
  String email;
  String phone;
  bool isChecked;
  DistributorsModel({this.email,this.name,this.phone,this.isChecked});
}

List<DistributorsModel> dummyDistributor=[
  DistributorsModel(name: "Panos Food",isChecked: false),
  DistributorsModel(name: "Greco & Sons",isChecked: false),
  DistributorsModel(name: "Turano Bakery",isChecked: false),
  DistributorsModel(name: "J & K Proviaions",isChecked: false),
  DistributorsModel(name: "Sysco Foods",isChecked: false),
];
