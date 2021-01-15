class DistributorsModel{

  String distributorName;
  String distributorEmail;
  String distributorPhone;
  bool isChecked;
  DistributorsModel({this.distributorEmail,this.distributorName,this.distributorPhone,this.isChecked});


}
List<DistributorsModel> dummyDistributor=[

  DistributorsModel(distributorName: "Distributor",isChecked: false),
  DistributorsModel(distributorName: "Distributor",isChecked: false),
  DistributorsModel(distributorName: "Distributor",isChecked: false),
  DistributorsModel(distributorName: "Distributor",isChecked: false),
  DistributorsModel(distributorName: "Distributor",isChecked: false),
  DistributorsModel(distributorName: "Distributor",isChecked: false),
  DistributorsModel(distributorName: "Distributor",isChecked: false),
  DistributorsModel(distributorName: "Distributor",isChecked: false),
  DistributorsModel(distributorName: "Distributor",isChecked: false)
];
