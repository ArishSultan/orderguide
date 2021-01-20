import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DismissibleTile extends StatelessWidget {
  final Widget child;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  DismissibleTile({this.child, this.onEdit, this.onRemove});

  static const spacing1 = SizedBox(width: 10);
  static const spacing2 = SizedBox(width: 15);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      secondaryBackground: Row(
        children: [
          const Text('Remove', style: TextStyle(color: Colors.red)),
          spacing1,
          const Icon(CupertinoIcons.delete, color: Colors.red),
          spacing2,
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
      background: Row(children: [
        spacing2,
        const Icon(CupertinoIcons.pencil, color: Colors.green),
        spacing1,
        const Text('Edit', style: TextStyle(color: Colors.green)),
      ]),
      child: child,
    );
  }
}