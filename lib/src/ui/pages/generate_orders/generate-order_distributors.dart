import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderguide/src/models/distributors-model.dart';
import 'package:unicons/unicons.dart';
import '../../widgets/text_field.dart';
import 'generate-order_items.dart';

class GenerateOrderDistributorsList extends StatefulWidget {
  @override
  _GenerateOrderDistributorsListState createState() =>
      _GenerateOrderDistributorsListState();
}

class _GenerateOrderDistributorsListState
    extends State<GenerateOrderDistributorsList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose a Distributor"),centerTitle:true ,),
      body: dummyDistributor.isEmpty
          ? Center(
              child: Text("No Distributor Found"),
            )
          : Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: AppTextField(
                  icon: UniconsLine.search,
                  placeholder: "Search Distributor",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: dummyDistributor.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey[500].withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          child: ListTile(onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GenererateOrderItems()));
                            },
                            contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text(
                                dummyDistributor[i].name[0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              dummyDistributor[i].name,
                              style: GoogleFonts.quicksand(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                      );
                    }),
              ),
            ],
          ),
      //ListView(),
    );
  }
}
