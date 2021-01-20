import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('18, January 2021'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x08000000),
                    offset: Offset(0, 25),
                    blurRadius: 40,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Panos Foods",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 20
                    ),),
                  )),
                  orderItem(),
                  orderItem(),
                  orderItem(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:25.0,vertical: 10),
                    child: Divider(thickness: 1,color: Colors.black26,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOTAL ',
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 15,
                            color: const Color(0xff000000),
                            height: 0.9333333333333333,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text("\$ 54",style: TextStyle(
                          fontSize: 17
                        ),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget orderItem(){
    return Padding(
      padding: const EdgeInsets.only(left:20.0,right: 20,top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hot Dogs',
                style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 15,
                  color: const Color(0xff000000),
                  height: 0.9333333333333333,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10,),
              Text(
                'Quantity : 4',
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12,
                  color: const Color(0x994b41f1),
                  height: 1.1666666666666667,
                ),
                textAlign: TextAlign.left,
              )
            ],
          ),
          Expanded(child: Container()),
          Text(
            '\$18',
            style: TextStyle(
              fontFamily: 'Poppins-SemiBold',
              fontSize: 15,
              color: Colors.grey,
              height: 0.9333333333333333,
            ),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}
