import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTile extends StatelessWidget {
 final Function onTap;
 final String title,description,image;
 final String details;
 final IconData icon;
  HomeTile({this.description,this.title,this.image,this.onTap,this.details,this.icon = Icons.edit});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: GestureDetector(
        onTap: onTap,
        child:   Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:40.0,bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                      colors: [
                    Colors.blue[600],
                    Colors.blue[700],
                    Colors.blue[800],
                    Colors.blue[900],
                  ]
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:60.0,right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(title,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize: 20,),),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.18,
                height: 70.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image:DecorationImage(
                    image: AssetImage(image),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(10, 10),
                      blurRadius: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
