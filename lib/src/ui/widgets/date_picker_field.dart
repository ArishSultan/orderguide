import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePickerFormField extends StatefulWidget {
  final bool allowPast;
  final String label;
  final DateTime value;
  final Function(DateTime) onChanged;

  const DatePickerFormField({
    this.allowPast = true,
    this.label,
    this.value,
    this.onChanged,
  });

  @override
  _DatePickerFormFieldState createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  DateTime _rawDate;
  final _controller = TextEditingController();

  set date(DateTime date) {
    _rawDate = date;
    _controller.text = DateFormat('dd MMM yyyy').format(date);
  }

  @override
  void initState() {
    super.initState();
    date = widget.value ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _controller,
      onTap: _handleSelection,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            CupertinoIcons.calendar,
            color: Theme.of(context).primaryColor,
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          minHeight: 10,
          maxHeight: 20,
          maxWidth: 30,
        ),
        isDense: true,
        labelText: widget.label,
        labelStyle: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 1.5,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  void _handleSelection() async {
    final data = await showDatePicker(
      context: context,
      lastDate: DateTime(3000),
      firstDate: widget.allowPast ? DateTime(1900) : _rawDate,
      initialDate: _rawDate,
    );

    if (data != null){
      date = data;
      widget.onChanged(data);
    }
  }
}
