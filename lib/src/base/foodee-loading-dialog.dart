import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

openLoadingDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      insetPadding: EdgeInsets.all(100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 35,
            height: 35,
            child: CircularProgressIndicator(backgroundColor: Colors.red,),
          ),
          SizedBox(height: 15),
          Text(text + "...",
              style: GoogleFonts.quicksand(),
    )
        ],
      ),
    ),
  );
}
