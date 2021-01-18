import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class AppTextField extends StatefulWidget {
  final bool _isPassword;

  final IconData icon;
  final Key key;
  final String placeholder;
  final Function(String) onSaved;
  final TextInputType keyboardType;
  final AutovalidateMode autoValidateMode;
  final String Function(String) validator;

  AppTextField({
    @required this.key,
    @required this.icon,
    @required this.placeholder,
    @required this.onSaved,
    this.keyboardType,
    this.validator,
    this.autoValidateMode = AutovalidateMode.disabled,
  }) : _isPassword = false;

  AppTextField.password({
    @required this.icon,
    @required this.key,
    @required this.placeholder,
    @required this.onSaved,
    this.keyboardType,
    this.validator,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
  }) : _isPassword = true;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    if (widget._isPassword) {
      return _PasswordField(
        key: widget.key,
        icon: widget.icon,
        onSaved: widget.onSaved,
        validator: widget.validator,
        placeholder: widget.placeholder,
        keyboardType: widget.keyboardType,
        autoValidateMode: widget.autoValidateMode,
      );
    } else {
      return _TextField(
        key: widget.key,
        icon: widget.icon,
        onSaved: widget.onSaved,
        validator: widget.validator,
        placeholder: widget.placeholder,
        keyboardType: widget.keyboardType,
        autoValidateMode: widget.autoValidateMode,
      );
    }
  }
}

class _TextField extends StatelessWidget {
  final Widget suffix;
  final bool obscure;
  final IconData icon;
  final String placeholder;
  final Key key;

  final Function(String) onSaved;
  final TextInputType keyboardType;
  final AutovalidateMode autoValidateMode;
  final String Function(String) validator;

  _TextField({
    @required this.icon,
    @required this.placeholder,
    @required this.onSaved,
    this.obscure = false,
    @required this.key,
    this.suffix,
    this.keyboardType,
    this.validator,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  Widget build(BuildContext context) {
    const color = Colors.black12;

    return TextFormField(
      key: key,
      onSaved: onSaved,
      obscureText: obscure,
      keyboardType: keyboardType,
      autovalidateMode: autoValidateMode,
      style: GoogleFonts.quicksand(color: Colors.black, fontSize: 14),
      validator: validator,
      textAlign: TextAlign.center,
      cursorColor: Colors.blue[900],
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        hintText: placeholder,
        suffixIcon: suffix,
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        contentPadding:
        EdgeInsets.fromLTRB(30, 16, suffix != null ? -35 : 15, 16),
        fillColor: Colors.grey.withOpacity(.05),
        prefixIcon: icon != null
            ? CustomPaint(
          painter: _PrefixPainter(),
          child: Container(
            width: 57,
            height: 51,
            child: Center(
              child: Icon(
                icon,
                size: 24,
                color: Colors.brown,
              ),
            ),
            margin: const EdgeInsets.only(right: 5),
            padding: const EdgeInsets.only(right: 6),
          ),
        )
            : null,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  final IconData icon;
  final String placeholder;
  final Function(String) onSaved;
  final TextInputType keyboardType;
  final AutovalidateMode autoValidateMode;
  final String Function(String) validator;
  final Key key;

  _PasswordField({
    @required this.icon,
    @required this.placeholder,
    @required this.onSaved,
    this.keyboardType,
    this.validator,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    @required this.key,
  });

  @override
  __PasswordFieldState createState() => __PasswordFieldState();
}

class __PasswordFieldState extends State<_PasswordField> {
  var isObscured = true;

  @override
  Widget build(BuildContext context) {
    return _TextField(
      key: widget.key,
      icon: widget.icon,
      obscure: isObscured,
      onSaved: widget.onSaved,
      validator: widget.validator,
      suffix: TextButton(
        onPressed: () => setState(() => isObscured = !isObscured),
        style: TextButton.styleFrom(
            minimumSize: Size(50, 50),
            primary: Colors.black,
            onSurface: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: Icon(isObscured ? UniconsLine.eye : UniconsLine.eye_slash),
      ),
      placeholder: widget.placeholder,
      keyboardType: widget.keyboardType,
      autoValidateMode: widget.autoValidateMode,
    );
  }
}

class _PrefixPainter extends CustomPainter {
  const _PrefixPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height / 2;
    final paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..addArc(Rect.fromLTRB(0, 0, size.height, size.height), 0.641593, 5.05)
      ..lineTo(size.width - 5, radius)
      ..close();

    canvas.drawShadow(path.shift(Offset(0, -5)), Colors.black, 5, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
