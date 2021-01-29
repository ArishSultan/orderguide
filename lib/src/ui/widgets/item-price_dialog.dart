import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'text_field.dart';

class ItemPriceDialog extends StatefulWidget {
  final double price;

  ItemPriceDialog({this.price});

  @override
  State createState() => new ItemPriceDialogState();
}

class ItemPriceDialogState extends State<ItemPriceDialog> {
  var _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _price;

  void initState() {
    super.initState();
    _price = widget.price?.toString() ?? '';
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Center(
          child: Text(
            'Input cost for Distributor',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Form(
              key: _formKey,
              child: AppTextField(
                initialValue: _price,
                icon: UniconsLine.dollar_alt,
                placeholder: 'Cost',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSaved: (value) => _price = value,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red.shade900,
                    ),
                    child: Text('Cancel'),
                    onPressed: () =>
                        Navigator.of(context).pop(double.tryParse(_price)),
                  ),
                ),
                SizedBox(width: 25),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text('Submit'),
                    onPressed: () async {
                      _formKey.currentState.save();
                      Navigator.of(context).pop(double.tryParse(_price));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
