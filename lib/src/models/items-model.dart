
class ItemsModel {
  String name;
  int quantity;
  double price;
  ItemsModel({this.name,this.quantity=0,this.price=28.45});
}

List<ItemsModel> dummyItems = [
  ItemsModel(name: "Hot Dogs"),
  ItemsModel(name: "Bucket Mayo"),
  ItemsModel(name: "Onions"),
  ItemsModel(name: "6x6 Tomatos"),
  ItemsModel(name: "Green Peppers"),
  ItemsModel(name: "16SL Lids"),
  ItemsModel(name: "24J16 Cups"),
];
