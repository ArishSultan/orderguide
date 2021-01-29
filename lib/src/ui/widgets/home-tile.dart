import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTile extends StatelessWidget {
  final Function onTap;
  final String title, description, image;
  final String details;
  final IconData icon;

  HomeTile(
      {this.description,
      this.title,
      this.image,
      this.onTap,
      this.details,
      this.icon = Icons.edit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 120),
              padding: const EdgeInsets.only(left: 50.0, right: 8.0),
              margin: const EdgeInsets.only(left: 40.0, bottom: 20),
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
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment(-1, -0.2),
                child: Text(
                  title,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-1, -0.5),
              child: Image.asset(image, height: 70),
            ),
          ],
        ),
      ),
    );
  }
}
