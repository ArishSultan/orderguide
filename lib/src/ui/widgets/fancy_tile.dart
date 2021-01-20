import 'package:flutter/material.dart';

class FancyTile extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final VoidCallback onTap;

  FancyTile({this.title, this.leading, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: title,
          onTap: onTap,
          leading: leading,
          contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        ),
      ),
    );
  }
}
